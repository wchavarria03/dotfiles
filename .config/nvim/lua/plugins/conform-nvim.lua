local M = {}

M.plugins = {
    'https://github.com/stevearc/conform.nvim',
}

function M.setup()
    vim.g.autoformat = true

    require('conform').setup {
        formatters_by_ft = {
            bash = { 'shfmt' },
            css = { 'stylelint', 'prettier', stop_after_first = true },
            go = { 'golines', 'goimports', 'gofumpt' },
            http = { 'kulala' },
            javascript = { 'prettierd', 'prettier', stop_after_first = true },
            javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
            json = { 'biome', 'prettier' },
            less = { 'stylelint' },
            lua = { 'stylua' },
            markdown = { 'prettier' },
            ['markdown.mdx'] = { 'prettier' },
            python = { 'isort', 'black', 'ruff' },
            scss = { 'stylelint' },
            solidity = { 'prettierd' },
            terraform = { 'terraform_fmt' },
            toml = { 'taplo' },
            typescript = { 'prettierd', 'prettier', stop_after_first = true },
            typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
            yaml = { 'prettier' },
        },
        formatters = {
            kulala = {
                command = 'kulala-fmt',
                args = { 'format', '$FILENAME' },
                stdin = false,
            },
        },
        format_on_save = function(bufnr)
            if vim.g.autoformat then
                local disable_filetypes = {
                    sh = true,
                    make = true,
                    dockerfile = true,
                }
                return {
                    timeout_ms = 3000,
                    lsp_format = disable_filetypes[vim.bo[bufnr].filetype] and 'never' or 'fallback',
                }
            end
        end,
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>cF', function()
        require('conform').format { formatters = { 'injected' }, timeout_ms = 3000 }
    end, { desc = 'Format Injected Langs' })
end

return M
