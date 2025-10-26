vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

vim.g.autoformat = true

require('conform').setup {
    formatters_by_ft = {
        -- Core languages
        bash = { 'shfmt' },
        lua = { 'stylua' },
        python = { 'isort', 'black', 'ruff' },
        go = { 'golines', 'goimports', 'gofumpt' },

        -- Web development
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'biome', 'prettier' },
        css = { 'stylelint', 'prettier', stop_after_first = true },
        less = { 'stylelint' },
        scss = { 'stylelint' },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        yaml = { 'prettier' },

        -- Documentation
        markdown = { 'prettier' },
        ['markdown.mdx'] = { 'prettier' },

        -- Infrastructure
        terraform = { 'terraform_fmt' },

        -- Specialized
        solidity = { 'prettierd' },

        -- Configuration files
        toml = { 'taplo' },
        http = { 'kulala' },
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

            local lsp_format_opt
            if disable_filetypes[vim.bo[bufnr].filetype] then
                lsp_format_opt = 'never'
            else
                lsp_format_opt = 'fallback'
            end
            return {
                timeout_ms = 3000,
                lsp_format = lsp_format_opt,
            }
        else
            return
        end
    end,

    keys = {
        {
            '<leader>cF',
            function()
                require('conform').format { formatters = { 'injected' }, timeout_ms = 3000 }
            end,
            mode = { 'n', 'v' },
            desc = 'Format Injected Langs',
        },
    },
}
