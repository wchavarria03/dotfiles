return {
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        build = ':MasonUpdate',
        opts = {
            ui = {
                border = 'single',
            },
        },
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            require('mason-lspconfig').setup {
                ensure_installed = {
                    -- Bash
                    'bashls',

                    -- BeanCount
                    'beancount',

                    -- Docker
                    'dockerls',
                    'docker_compose_language_service',

                    -- Go
                    'gopls',

                    -- JSON
                    'jsonls',

                    -- Lua
                    'lua_ls',

                    -- Markdown
                    'marksman',

                    -- Ruby
                    -- "ruby_lsp", -- Having issues installing this one

                    -- TypeScript / Javascript
                    'ts_ls',

                    -- YAML
                    'yamlls',
                },
                automatic_installation = true,
            }
        end,
    },
}
