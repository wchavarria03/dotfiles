return {
  -- Formatting for markdown files
  {
    'stevearc/conform.nvim',
    event = 'VeryLazy',
    cmd = 'ConformInfo',
    dependencies = {
      'zapling/mason-conform.nvim',
    },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { timeout_ms = 3000 }
        end,
        mode = { 'n', 'v' },
        desc = 'Format buffer',
      },
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
          -- Documentation
          markdown = { 'prettier' },
          ['markdown.mdx'] = { 'prettier' },
          
          -- Configuration files
          json = { 'prettier' },
          yaml = { 'prettier' },
          toml = { 'taplo' },
        },
      }
      vim.g.autoformat = true
      return opts
    end,
  },
} 