return {
    'saghen/blink.cmp',
    version = '*',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
        'giuxtaposition/blink-cmp-copilot',
    },
    opts = {
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
        },
    },
    config = function(_, opts)
        require('blink.cmp').setup(opts)

        -- vim.api.nvim_create_autocmd("User", {
        --   pattern = "BlinkCmpMenuOpen",
        --   callback = function()
        --     vim.b.copilot_suggestion_hidden = true
        --   end,
        -- })
        --
        -- vim.api.nvim_create_autocmd("User", {
        --   pattern = "BlinkCmpMenuClose",
        --   callback = function()
        --     vim.b.copilot_suggestion_hidden = false
        --   end,
        -- })
    end,
}
