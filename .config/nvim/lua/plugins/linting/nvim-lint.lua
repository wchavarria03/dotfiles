local M = {}

M.plugins = {
    'https://github.com/mfussenegger/nvim-lint',
}

function M.setup()
    require('lint').linters_by_ft = {
        bash = { 'shellcheck' },
        css = { 'stylelint' },
        dockerfile = { 'hadolint' },
        go = { 'golangci-lint' },
        javascript = { 'eslint_d' },
        json = { 'biome', 'jsonlint' },
        less = { 'stylelint' },
        lua = { 'luacheck' },
        markdown = { 'markdownlint', 'cspell', 'codespell' },
        python = { 'ruff', 'flake8' },
        scss = { 'stylelint' },
        solidity = { 'solhint' },
        terraform = { 'tflint' },
        text = { 'cspell', 'codespell' },
        typescript = { 'eslint_d' },
        yaml = { 'yamllint' },
        ['_'] = { 'cspell', 'codespell' },
    }
end

return M
