return {
  "saghen/blink.cmp",
  version = "*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "fang2hou/blink-copilot",
    "rafamadriz/friendly-snippets",
  },
  opts = {
    completion = {
      menu = {
        border = "single",
        draw = {
          columns = {
            { "kind_icon", "label", gap = 1 },
            { "label_description", gap = 2, "kind" },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = true,
      },
      list = {
        selection = {
          preselect = false,
        },
      },
      performance = {
        debounce_ms = 80,
        throttle_ms = 80,
        cache_size = 100,
        max_results = 50,
      },
    },
    snippets = {
      preset = "luasnip",
    },

    sources = {
      default = { "copilot", "lazydev", "snippets", "lsp", "path", "buffer" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },
        -- LuaLS completion source
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100, -- show at a higher priority than lsp
        },
        lsp = {
          name = "lsp",
          score_offset = 90,
          async = true,
          cache = {
            enabled = true,
            max_size = 100,
          },
        },
        snippets = {
          name = "snippets",
          score_offset = 80,
        },
        buffer = {
          name = "buffer",
          score_offset = 60,
          max_item_count = 10,
        },
        path = {
          name = "path",
          score_offset = 50,
          trailing_slash = true,
        },
      },
    },
    keymap = {
      preset = "default",
    },
  },
  config = function(_, opts)
    require("blink.cmp").setup(opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuOpen",
      callback = function()
        vim.b.copilot_suggestion_hidden = true
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuClose",
      callback = function()
        vim.b.copilot_suggestion_hidden = false
      end,
    })
  end,
}
