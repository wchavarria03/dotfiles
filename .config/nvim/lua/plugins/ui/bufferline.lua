return {
  "akinsho/bufferline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
    { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    { "<leader>bb", "<cmd>e #<cr>", desc = "Switch to Other Buffer" },
    {
      "<leader>bd",
      function()
        require("snacks").bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>bo",
      function()
        require("snacks").bufdelete.other()
      end,
      desc = "Delete Other Buffers",
    },
    { "<leader>bD", "<cmd>:bd<cr>", desc = "Delete Buffer and Window" },
  },
  opts = function()
    -- opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
    local bufferline = require("bufferline")
    return {
      style_preset = bufferline.style_preset.no_italic,
      numbers = "ordinal",
      show_buffer_close_icons = false,
      diagnostics = "nvim_lsp",
      indicator = {
        style = "icon",
        icon = "|",
      },
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          text_align = "center",
          separator = true,
        },
      },
      hover = {
        enabled = false,
      },
    }
  end,
  config = function(_, opts)
    local bufferline = require("bufferline")
    bufferline.setup({
      options = opts,
      -- highlights = {
      --   buffer_selected = {
      --     bold = false,
      --     italic = false,
      --     fg = "#000000",
      --     bg = "#9cdf9b",
      --   },
      --   numbers_selected = {
      --     bold = false,
      --     italic = false,
      --     fg = "#000000",
      --     bg = "#9cdf9b",
      --   },
      -- },
      -- require("catppuccin.groups.integrations.bufferline").config(),
    })
  end,
}
