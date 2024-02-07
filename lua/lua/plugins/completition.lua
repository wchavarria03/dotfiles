-----------------------------------------------------------
-- Autocomplete configuration file
-----------------------------------------------------------
return {
  {
    'hrsh7th/nvim-cmp',
    event = { "InsertEnter", "CmdlineEnter" },
    opts = function(_, opts)
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      --   פּ ﯟ   some other good icons
      local kind_icons = {
        Text = "",
        Method = "m",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "",
        Copilot = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      }

      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
      end

      local winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:Search'
      opts.window = {
        completion = cmp.config.window.bordered({ winhighlight = winhighlight, border = 'single' }),
        documentation = cmp.config.window.bordered({ winhighlight = winhighlight, border = 'single' }),
        preview = cmp.config.window.bordered({ winhighlight = winhighlight, border = 'single' }),
      }

      opts.mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-h>"] = cmp.mapping.scroll_docs(-4),
        ["<C-l>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-y>"] = cmp.config.disable,
        ['<esc>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
          elseif require("copilot.suggestion").is_visible() then
            require("copilot.suggestion").accept()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end

        end, {
        'i',
        's'
        });
      });

      opts.sources = cmp.config.sources({
        { name = 'nvim_lsp', keyword_length = 2 },
        { name = "copilot", group_index = 2, priority = 60 },
        { name = "luasnip", keyword_length = 2 },
        {
          name = 'buffer',
          keyword_length = 3,
          options = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end
          }
        },
        { name = 'path' },
        { name = 'treesitter' },
      });

      opts.sorting = opts.sorting or require('cmp.config.default')().sorting;
      opts.sorting.comparators = {
        require('copilot_cmp.comparators').prioritize,
        unpack(opts.sorting.comparators or {})
      }

      opts.snippet = {
        expand = function (args)
          luasnip.lsp_expand(args.body)
        end
      }

      opts.formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
          vim_item.menu = ({
            nvim_lsp = '[LSP]',
            luasnip = '[LuaSnip]',
            buffer = '[Buffer]',
            path = '[Path]',
            nvim_lua = '[Lua]',
            cmdline = '[Cmdline]',
            copilot = '[Copilot]'
          })[entry.source.name]
          return vim_item
        end,
      }

      opts.confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false
      }

      opts.experimental = {
        ghost_text = false
      }
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      -- 'hrsh7th/cmp-cmdline',                  -- nvim-comp for vim's cmdline
      'hrsh7th/cmp-nvim-lsp-document-symbol', -- completition for textDocument/documentSymbol via nvim-lsp
      'petertriho/cmp-git',

      'windwp/nvim-autopairs',                -- autopairing of (){}[] etc
      'zbirenbaum/copilot-cmp',
    }
  },
  {
    'windwp/nvim-autopairs',
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
      check_ts = true,
      ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
      }
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      -- setup cmp for autopairs
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {'zbirenbaum/copilot.lua'},
    config = function (_, opts)
      local copilot_cmp = require('copilot_cmp')
      copilot_cmp.setup(opts)

      -- attach cmp source whenever copilot attaches
      -- fixes lazy-loading issues with the copilot cmp source
      local copilotAttach
      copilotAttach = vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client ~= nil and client.name == 'copilot' then
            copilot_cmp._on_insert_enter({})
          end
        end,
        -- on_detach = function ()
        --  vim.api.nvim_del_autocmd({id = copilotAttach, clear = true})
        -- end,
      })
    end
  }
}
