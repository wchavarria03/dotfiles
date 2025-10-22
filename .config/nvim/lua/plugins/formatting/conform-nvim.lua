return {
    'stevearc/conform.nvim',
    event = 'VeryLazy',
    cmd = 'ConformInfo',
    dependencies = {
        'zapling/mason-conform.nvim',
    },
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
    opts = function()
        local opts = {
            default_format_opts = {
                lsp_format = 'fallback',
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
                dockerfile = { 'hadolint' },
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
        }
        vim.g.autoformat = true
        return opts
    end,
}
