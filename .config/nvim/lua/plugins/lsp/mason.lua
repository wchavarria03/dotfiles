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
                    -- Core languages
                    'bashls',                    -- Bash
                    'gopls',                     -- Go
                    'jsonls',                    -- JSON
                    'lua_ls',                    -- Lua
                    'ts_ls',                     -- TypeScript/JavaScript
                    'yamlls',                    -- YAML

                    -- Web development
                    'html',                      -- HTML
                    'cssls',                     -- CSS
                    'emmet_ls',                  -- Emmet

                    -- Infrastructure & DevOps
                    'dockerls',                  -- Docker
                    'docker_compose_language_service', -- Docker Compose

                    -- Documentation
                    'marksman',                  -- Markdown

                    -- Configuration files
                    'taplo',                     -- TOML
                    'yamlls',                    -- YAML

                    -- Specialized
                    'beancount',                 -- Beancount
                    'solidity_ls',               -- Solidity
                    'ruby_lsp',                  -- Ruby
                },
                automatic_installation = true,
            }
        end
    }
}
