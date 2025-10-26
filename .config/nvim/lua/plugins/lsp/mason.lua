vim.pack.add {
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
    { src = 'https://github.com/b0o/SchemaStore.nvim' },
}

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
        'pyright', -- pyright (python)
        'golangci_lint_ls', -- biome (javascript/typescript) and golangci-lint
        'terraformls', -- terraform
        'cairo_ls', -- cairo

        'beancount',

        -- Linters
        -- ruff
        -- tflint  -- (terraform linter)
    },
}

vim.lsp.config('jsonls', {
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
    },
})

vim.lsp.config('yamlls', {
    settings = {
        yaml = {
            schemas = require('schemastore').yaml.schemas(),
        },
    },
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }, -- Recognize 'vim' as a global variable
            },
        },
    },
})
