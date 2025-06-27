return {
    'rshkarin/mason-nvim-lint',
    event = 'VeryLazy',
    opts = {
        -- Only install linters that are available in Mason's registry
        ensure_installed = {
            -- Core linters that are definitely available
            'shellcheck', -- bash
            'luacheck', -- lua
            'flake8', -- python
            'eslint_d', -- javascript/typescript
            -- 'golangci-lint', -- go        --  (DO not work with auto_install)
            'hadolint', -- dockerfile
            -- 'biome', -- json              -- (DO not work with auto_install)
            'cspell', -- spell checking
            'codespell', -- spell checking
            'yamllint', -- yaml
            'ruff', -- python (modern alternative to flake8)
        },
        -- Ignore problematic linters that aren't available in Mason's registry
        ignore_install = {
            'clj-kondo', -- Not available in Mason
            'inko', -- Not available in Mason
            'janet', -- Not available in Mason
            'ruby', -- Use rubocop instead
        },
        automatic_installation = true,
    },
}
