local M = {}

M.plugins = {
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
    'https://github.com/b0o/SchemaStore.nvim',
}

function M.setup()
    require('mason').setup()

    require('mason-lspconfig').setup {
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
            -- 'pyright', -- pyright (python)
            'basedpyright',
            'golangci_lint_ls', -- biome (javascript/typescript) and golangci-lint
            'terraformls', -- terraform
            'cairo_ls', -- cairo

            'beancount',

            -- Linters
            -- ruff
            -- tflint  -- (terraform linter)
        },
    }
end

return M
