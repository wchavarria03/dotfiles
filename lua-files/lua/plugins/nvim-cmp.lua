-----------------------------------------------------------
-- Autocomplete configuration file
-----------------------------------------------------------

-- Plugin: nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp
return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  opts = function(_, opts)
    local cmp = require 'cmp'
    local winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:Search"

    local sources = {
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
      { name = "nvim_lua" },
    }

    local mappings = {
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
    }

    local window = {
      completion = cmp.config.window.bordered({ winhighlight = winhighlight, border = "single" }),
      documentation = cmp.config.window.bordered({ winhighlight = winhighlight, border = "single" }),
      preview = cmp.config.window.bordered({ winhighlight = winhighlight, border = "single" }),
    }

    local confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }

    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "cmp_git" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
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
        { name = "cmdline" },
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

    opts.window = window
    opts.mappings = cmp.mapping.preset.insert(mappings)
    opts.confirm_opts = confirm_opts
    opts.sources = cmp.config.sources(sources);

  end,
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'f3fora/cmp-spell',     -- TODO CHECK THIS ONE
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-document-symbol'  -- TODO CHECK THIS ONE
  }
}

-- vim.opt.spell = true
-- vim.opt.spelllang = { 'en_us' }
