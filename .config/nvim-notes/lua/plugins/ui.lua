return {
  -- Which-key for keybinding discovery (reuse from regular config)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      
      -- Register key groups with new format
      wk.register({
        {
          mode = { "n", "v" },
          { "<leader>f", group = "file/find" },
          { "<leader>s", group = "search" },
          { "<leader>m", group = "markdown" },
          { "<leader>i", group = "image" },
        },
      })
    end,
  },
  
  -- Web devicons for file icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
        strict = true,
        override_by_filename = {
          ["README.md"] = { icon = "󰋼", color = "#ffd700", name = "Readme" },
          ["TODO.md"] = { icon = "󰅚", color = "#ff6b6b", name = "Todo" },
          ["todos.md"] = { icon = "󰅚", color = "#ff6b6b", name = "Todos" },
          ["notes.md"] = { icon = "󰎚", color = "#74c7ec", name = "Notes" },
        },
        override_by_extension = {
          ["md"] = { icon = "󰍔", color = "#74c7ec", name = "Markdown" },
        },
      })
    end,
  },
} 