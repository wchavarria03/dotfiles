return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    input = {
      enabled = true,
    },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
    vim.ui.input = require("snacks").input
  end,
} 