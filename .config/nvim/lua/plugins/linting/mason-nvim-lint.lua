vim.pack.add { 'https://github.com/rshkarin/mason-nvim-lint' }

require('mason-nvim-lint').setup {
    -- Only install linters that are available in Mason's registry
    ensure_installed = {
        'codespell', -- spell checking
        'cspell', -- spell checking
        'eslint_d', -- javascript/typescript
        'flake8', -- python
        'hadolint', -- dockerfile
        'luacheck', -- lua
        'ruff', -- python (modern alternative to flake8)
        'shellcheck', -- bash
        'tflint', -- terraform
        'yamllint', -- yaml
        -- 'biome', -- json              -- (DO not work with auto_install)
        -- 'golangci-lint', -- go        --  (DO not work with auto_install)
    },
    -- Ignore problematic linters that aren't available in Mason's registry
    -- So they won't be installed automatically but could still be installed by mason
    ignore_install = {
        'biome',
        'clj-kondo', -- Not available in Mason
        'golangci-lint',
        'inko', -- Not available in Mason
        'janet', -- Not available in Mason
    },
    automatic_installation = true,
}
