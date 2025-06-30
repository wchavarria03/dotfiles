return {
    'mfussenegger/nvim-lint',
    event = 'VeryLazy',
    dependencies = {
        'rshkarin/mason-nvim-lint',
    },
    opts = {
        events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
        linters_by_ft = {
            bash = { 'shellcheck' },
            dockerfile = { 'hadolint' },
            go = { 'golangci-lint' },
            javascript = { 'eslint_d' },
            json = { 'biome' },
            lua = { 'luacheck' },
            python = { 'ruff', 'flake8' },
            typescript = { 'eslint_d' },
            solidity = { 'solhint' },
            yaml = { 'yamllint' },
            markdown = { 'cspell', 'codespell' },
            text = { 'cspell', 'codespell' },
            -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
            ['_'] = { 'cspell', 'codespell' },
        },
    },
    config = function()
        vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
            callback = function()
                require('lint').try_lint()
            end,
        })
    end,
}
