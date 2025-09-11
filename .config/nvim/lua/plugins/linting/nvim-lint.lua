return {
    'mfussenegger/nvim-lint',
    event = 'VeryLazy',
    dependencies = {
        'rshkarin/mason-nvim-lint',
    },
    config = function()
        local lint = require 'lint'
        lint.linters_by_ft = {
            bash = { 'shellcheck' },
            dockerfile = { 'hadolint' },
            go = { 'golangci-lint' },
            javascript = { 'eslint_d' },
            json = { 'biome', 'jsonlint' },
            lua = { 'luacheck' },
            markdown = { 'markdownlint', 'cspell', 'codespell' },
            python = { 'ruff', 'flake8' },
            solidity = { 'solhint' },
            terraform = { 'tflint' },
            text = { 'cspell', 'codespell' },
            typescript = { 'eslint_d' },
            yaml = { 'yamllint' },
            -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
            ['_'] = { 'cspell', 'codespell' }, -- fallback

            css = { 'stylelint' },
            scss = { 'stylelint' },
            less = { 'stylelint' },
        }
    end,
}
