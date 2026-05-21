local M = {}

M.plugins = {
    'https://github.com/rshkarin/mason-nvim-lint',
}

function M.setup()
    require('mason-nvim-lint').setup {
        ensure_installed = {
            'codespell',
            'cspell',
            'eslint_d',
            'flake8',
            'hadolint',
            'luacheck',
            'ruff',
            'shellcheck',
            'tflint',
            'yamllint',
        },
        ignore_install = {
            'biome',
            'clj-kondo',
            'golangci-lint',
            'inko',
            'janet',
        },
        automatic_installation = true,
    }
end

return M
