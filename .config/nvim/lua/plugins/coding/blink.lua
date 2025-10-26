-- ============================================================================
-- blink.cmp Configuration
-- ============================================================================
-- Completion plugin with fuzzy matching (auto-builds from source)

-- ----------------------------------------------------------------------------
-- Auto-build Hook
-- ----------------------------------------------------------------------------

local function build_blink_cmp(plugin_path)
    vim.notify('Building blink.cmp...', vim.log.levels.INFO)

    local result = vim.system({ 'cargo', 'build', '--release' }, { cwd = plugin_path }):wait()

    if result.code == 0 then
        vim.notify('blink.cmp build complete!', vim.log.levels.INFO)
    else
        vim.notify('blink.cmp build failed!', vim.log.levels.ERROR)
        if result.stderr then
            vim.notify('Build error: ' .. vim.trim(result.stderr), vim.log.levels.ERROR)
        end
    end
end

-- Register build hook (must be before vim.pack.add)
vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('BlinkCmpBuild', { clear = true }),
    callback = function(event)
        local plugin_name = event.data.spec.source:match '/([^/]+)$'
        local action = event.data.kind

        if plugin_name == 'blink.cmp' and (action == 'install' or action == 'update') then
            if event.data.path and event.data.path ~= '' then
                build_blink_cmp(event.data.path)
            end
        end
    end,
})

-- ----------------------------------------------------------------------------
-- Plugin Installation
-- ----------------------------------------------------------------------------

vim.pack.add {
    {
        src = 'https://github.com/saghen/blink.cmp',
        version = vim.version.range '1.*',
    },
    'https://github.com/giuxtaposition/blink-cmp-copilot',
}

-- ----------------------------------------------------------------------------
-- Plugin Setup
-- ----------------------------------------------------------------------------

require('blink.cmp').setup {
    completion = {
        menu = {
            border = 'single',
            draw = {
                columns = {
                    { 'kind_icon', 'label', gap = 1 },
                    { 'label_description', gap = 2, 'kind' },
                },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },
        ghost_text = {
            enabled = true,
        },
        list = {
            selection = {
                preselect = false,
            },
        },
    },

    sources = {
        default = { 'copilot', 'lsp', 'path', 'buffer' },
        providers = {
            copilot = {
                name = 'copilot',
                module = 'blink-cmp-copilot',
                score_offset = 100,
                async = true,
            },
        },
    },

    keymap = {
        preset = 'default',
        ['<Tab>'] = {
            'snippet_forward',
            function()
                return vim.lsp.inline_completion.get()
            end,
            'fallback',
        },
    },
}
