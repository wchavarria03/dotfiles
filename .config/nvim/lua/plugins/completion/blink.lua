local M = {}

M.plugins = {
    {
        src = 'https://github.com/saghen/blink.cmp',
        version = vim.version.range '1.*',
    },
    'https://github.com/giuxtaposition/blink-cmp-copilot',
}

function M.setup()
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
            default = { 'lazydev', 'copilot', 'lsp', 'path', 'buffer' },
            providers = {
                lazydev = {
                    name = 'LazyDev',
                    module = 'lazydev.integrations.blink',
                    score_offset = 100,
                },
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
end

return M
