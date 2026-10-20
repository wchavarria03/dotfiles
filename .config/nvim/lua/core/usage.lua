local M = {}

local REVIEW_DAYS = 14
local path = vim.fs.joinpath(vim.fn.stdpath 'state', 'plugin-usage.json')
local stamp = vim.fs.joinpath(vim.fn.stdpath 'state', 'plugin-usage-review')
local config_lua = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua') .. '/'
local pack_dir = vim.fs.joinpath(vim.fn.stdpath 'data', 'site', 'pack', 'core', 'opt') .. '/'
local this_file = debug.getinfo(1, 'S').source

---@type table<string, table<string, integer>> owner -> key -> count
local counts = {}

---Every countable mapping registered this session, so a reset can re-seed zero rows.
---@type table<string, table<string, true>>
local registered = {}

local function bump(owner, key)
    counts[owner] = counts[owner] or {}
    counts[owner][key] = (counts[owner][key] or 0) + 1
end

---Owner of a mapping: the plugin that registered it, otherwise the config file.
---@return string
local function owner()
    for level = 2, 12 do
        local info = debug.getinfo(level, 'S')
        if not info then
            break
        end
        local source = info.source
        if source ~= this_file and source:sub(1, 1) == '@' then
            local file = source:sub(2)
            if vim.startswith(file, pack_dir) then
                return 'pack/' .. file:sub(#pack_dir + 1):match '^[^/]+'
            elseif vim.startswith(file, config_lua) then
                return file:sub(#config_lua + 1)
            end
            if vim.startswith(file, vim.env.VIMRUNTIME) then
                return 'runtime'
            end
            return 'other'
        end
    end
    return 'unknown'
end

local function wrap_keymaps()
    local original = vim.keymap.set

    vim.keymap.set = function(mode, lhs, rhs, opts)
        local who = owner()
        -- register with zero so never-pressed mappings still show up in the report;
        -- uncountable mappings are skipped so they can't make an owner look unused
        local function register()
            counts[who] = counts[who] or {}
            counts[who][lhs] = counts[who][lhs] or 0
            registered[who] = registered[who] or {}
            registered[who][lhs] = true
        end

        local expr = type(opts) == 'table' and opts.expr
        if type(rhs) == 'function' then
            local fn = rhs
            register()
            rhs = function(...)
                bump(who, lhs)
                return fn(...)
            end
        elseif type(rhs) == 'string' and not expr and rhs:lower():find('^<cmd>') then
            -- '<Cmd>Foo<CR>' never passes through the cmdline, so wrap it. Other string rhs
            -- (<Plug>, plain keys) need remapping semantics, so they stay uncounted.
            local keys = vim.keycode(rhs)
            register()
            rhs = function()
                bump(who, lhs)
                vim.api.nvim_feedkeys(keys, 'nt', false)
            end
        end
        return original(mode, lhs, rhs, opts)
    end
end

local function track_commands()
    vim.api.nvim_create_autocmd('CmdlineLeave', {
        group = vim.api.nvim_create_augroup('core_usage', { clear = true }),
        callback = function()
            if vim.v.event.abort or vim.fn.getcmdtype() ~= ':' then
                return
            end
            local word = vim.fn.getcmdline():match "^[%s%d,;%%.$<>'+-]*(%a[%w_]*)"
            if word then
                bump('cmd', word)
            end
        end,
    })
end

---@return table<string, table<string, integer>>
local function read_saved()
    local ok, data = pcall(function()
        return vim.json.decode(table.concat(vim.fn.readfile(path), '\n'))
    end)
    return (ok and type(data) == 'table') and data or {}
end

---Merge this session into the saved totals and write them back.
local function flush()
    local total = read_saved()
    for who, keys in pairs(counts) do
        if type(total[who]) ~= 'table' then
            total[who] = {}
        end
        for key, n in pairs(keys) do
            total[who][key] = (total[who][key] or 0) + n
        end
    end
    counts = {}
    vim.fn.mkdir(vim.fs.dirname(path), 'p')
    pcall(vim.fn.writefile, { vim.json.encode(total) }, path)
end

local function flush_on_exit()
    vim.api.nvim_create_autocmd('VimLeavePre', {
        group = vim.api.nvim_create_augroup('core_usage_flush', { clear = true }),
        callback = function()
            pcall(flush)
        end,
    })
end

---Print saved totals (plus this session) per owner, least used first.
function M.report()
    flush() -- fold the live session in, so the report is current
    local rows = {}
    for who, keys in pairs(read_saved()) do
        local sum, mappings = 0, 0
        for _, n in pairs(keys) do
            sum = sum + n
            mappings = mappings + 1
        end
        table.insert(rows, { who = who, sum = sum, mappings = mappings })
    end
    table.sort(rows, function(a, b)
        if a.sum ~= b.sum then
            return a.sum < b.sum
        end
        return a.who < b.who
    end)

    local lines = { ('%-6s %-8s %s'):format('used', 'entries', 'owner (least used first)') }
    for _, row in ipairs(rows) do
        local flag = row.sum == 0 and '  <- never used' or ''
        table.insert(lines, ('%-6d %-8d %s%s'):format(row.sum, row.mappings, row.who, flag))
    end
    table.insert(lines, '')
    table.insert(lines, 'file: ' .. path)
    table.insert(lines, 'note: only function and <Cmd> mappings and ex commands are counted')
    vim.api.nvim_echo({ { table.concat(lines, '\n') } }, true, {})
end

---Nudge to run :PluginUsage once every REVIEW_DAYS. The clock resets when the nudge fires,
---not when the report is run, so an ignored nudge does not repeat on every startup.
local function remind_to_review()
    vim.api.nvim_create_autocmd('VimEnter', {
        once = true,
        callback = function()
            vim.defer_fn(function()
                local ok, lines = pcall(vim.fn.readfile, stamp)
                local last = ok and tonumber(lines[1]) or nil
                local now = os.time()
                if last and now - last < REVIEW_DAYS * 86400 then
                    return
                end
                vim.fn.mkdir(vim.fs.dirname(stamp), 'p')
                pcall(vim.fn.writefile, { tostring(now) }, stamp)
                if last then -- no stamp yet means first run: start the clock silently
                    vim.notify(('Plugin usage review due (every %d days): run :PluginUsage'):format(REVIEW_DAYS))
                end
            end, 1000)
        end,
    })
end

---Wipe all counts and restart the review clock. Still-registered mappings are re-seeded at zero,
---so "never used" keeps working without a restart; counting carries on from here.
function M.reset()
    local zeros = {}
    for who, keys in pairs(registered) do
        zeros[who] = {}
        for lhs in pairs(keys) do
            zeros[who][lhs] = 0
        end
    end
    counts = {}
    vim.fn.mkdir(vim.fs.dirname(path), 'p')
    pcall(vim.fn.writefile, { vim.json.encode(zeros) }, path)
    pcall(vim.fn.writefile, { tostring(os.time()) }, stamp)
    vim.notify 'Plugin usage counts reset'
end

function M.setup()
    wrap_keymaps()
    track_commands()
    flush_on_exit()
    remind_to_review()
    vim.api.nvim_create_user_command('PluginUsage', M.report, { desc = 'Show plugin usage counts' })
    vim.api.nvim_create_user_command('PluginUsageReset', M.reset, { desc = 'Clear plugin usage counts' })
end

return M
