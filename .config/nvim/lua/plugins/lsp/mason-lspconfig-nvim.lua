return {
    'mason-org/mason-lspconfig.nvim',
    opts = {
        ensure_installed = {
            -- Core languages
            'bashls', -- Bash
            'gopls', -- Go
            'jsonls', -- JSON
            'lua_ls', -- Lua
            'ts_ls', -- TypeScript/JavaScript
            'copilot',

            -- Web development
            'html', -- HTML
            'cssls', -- CSS
            'emmet_ls', -- Emmet
            -- 'stylelint_lsp', -- Stylelint

            -- Infrastructure & DevOps
            'dockerls', -- Docker
            'docker_compose_language_service', -- Docker Compose
            'yamlls', -- cairo

            -- Documentation
            'marksman', -- Markdown

            -- Configuration files
            'taplo', -- TOML

            -- Specialized
            'solidity_ls', -- Solidity

            'biome', -- biome (javascript/typescript)
            'pyright', -- pyright (python)
            'golangci_lint_ls', -- biome (javascript/typescript) and golangci-lint
            'terraformls', -- terraform
            'cairo_ls', -- cairo

            -- Linters
            -- ruff
            -- tflint  -- (terraform linter)
        },
    },
    dependencies = {
        {
            'mason-org/mason.nvim',
            cmd = 'Mason',
            build = ':MasonUpdate',
            opts = {
                ui = {
                    border = 'single',
                },
            },
        },
        'neovim/nvim-lspconfig',
    },
}
