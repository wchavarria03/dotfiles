local M = {}

M.copilot_status = function()
    local clients = vim.lsp.get_clients { name = 'copilot', bufnr = 0 }
    if #clients > 0 then
        local status = require('copilot.api').status.data.status
        return (status == 'InProgress' and '...') or (status == 'Warning' and 'X') or ''
    end
    return ''
end

M.mcphub_status = function()
    return {
        function()
            -- Check if MCPHub is loaded
            if not vim.g.loaded_mcphub then
                return '󰐻 -'
            end

            local count = vim.g.mcphub_servers_count or 0
            local status = vim.g.mcphub_status or 'stopped'
            local executing = vim.g.mcphub_executing

            -- Show "-" when stopped
            if status == 'stopped' then
                return '󰐻 -'
            end

            -- Show spinner when executing, starting, or restarting
            if executing or status == 'starting' or status == 'restarting' then
                local frames = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
                local frame = math.floor(vim.loop.now() / 100) % #frames + 1
                return '󰐻 ' .. frames[frame]
            end

            return '󰐻 ' .. count
        end,
        color = function()
            if not vim.g.loaded_mcphub then
                return { fg = '#6c7086' } -- Gray for not loaded
            end

            local status = vim.g.mcphub_status or 'stopped'
            if status == 'ready' or status == 'restarted' then
                return { fg = '#50fa7b' } -- Green for connected
            elseif status == 'starting' or status == 'restarting' then
                return { fg = '#ffb86c' } -- Orange for connecting
            else
                return { fg = '#ff5555' } -- Red for error/stopped
            end
        end,
    }
end

return M
