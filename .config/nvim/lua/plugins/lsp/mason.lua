-- Installed lsps

-- -- Core languages
-- 'bashls', -- Bash
-- 'gopls', -- Go
-- 'jsonls', -- JSON
-- 'lua_ls', -- Lua
-- 'ts_ls', -- TypeScript/JavaScript

-- -- Web development
-- 'html', -- HTML
-- 'cssls', -- CSS
-- 'emmet_ls', -- Emmet

-- -- Infrastructure & DevOps
-- 'dockerls', -- Docker
-- 'docker_compose_language_service', -- Docker Compose

-- -- Documentation
-- 'marksman', -- Markdown

-- -- Configuration files
-- 'taplo', -- TOML

-- -- Specialized
-- 'solidity_ls', -- Solidity
--
-- 'biome', -- biome (javascript/typescript)
-- 'pyright', -- pyright (python)
-- 'golangci_lint_ls', -- biome (javascript/typescript) and golangci-lint
-- 'terraform_ls',          -- terraform

-- -- Linters
-- -- ruff
-- -- tflint  -- (terraform linter)

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
}
