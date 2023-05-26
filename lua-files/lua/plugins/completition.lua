-----------------------------------------------------------
-- Autocomplete configuration file
-----------------------------------------------------------

-- Plugin: nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp
return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    opts = function(_, opts)
      local cmp = require 'cmp'

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          -- { name = "cmp_git" },
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })

      local cmd_mappings = {
        ["<Tab>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      }

      -- cmdline
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(cmd_mappings),
        sources = cmp.config.sources({
          {
            name = "cmdline",
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          },
          { name = "path", options = { trailing_slash = true, label_trailing_slash = true } },
          { name = "buffer" },
        }),
      })
      -- lsp_document_symbols
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(cmd_mappings),
        sources = cmp.config.sources({
          { name = 'nvim_lsp_document_symbol' },
          { name = 'buffer' }
        })
      })

      -- CMP general opts
      local winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:Search"
      opts.window = {
        completion = cmp.config.window.bordered({ winhighlight = winhighlight, border = "single" }),
        documentation = cmp.config.window.bordered({ winhighlight = winhighlight, border = "single" }),
        preview = cmp.config.window.bordered({ winhighlight = winhighlight, border = "single" }),
      }

      opts.mappings = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ['<C-y>'] = cmp.config.disable,
        ['<C-e>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
      })

      opts.confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }

      opts.sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'path' },
        {
          name = 'buffer',
          options = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end
          }
        },
        { name = 'treesitter' },
        { name = 'spell' },
      });

    end,
    dependencies = {
      'hrsh7th/cmp-buffer',                   -- nvim-comp for buffer words
      'hrsh7th/cmp-path',                     -- nvim-comp for filesystem paths.
      'hrsh7th/cmp-cmdline',                  -- nvim-comp for vim's cmdline
      'f3fora/cmp-spell',                     -- nvim-comp for spell suggestions
      'hrsh7th/cmp-nvim-lsp',                 -- nvim-comp for neovim's built in LSP
      'hrsh7th/cmp-nvim-lsp-document-symbol'  -- completition for textDocument/documentSymbol via nvim-lsp
    }
  },
  {
    'f3fora/cmp-spell',
    config = function ()
      vim.opt.spell = true
      vim.opt.spelllang = { 'en_us' }
    end
  }
}
