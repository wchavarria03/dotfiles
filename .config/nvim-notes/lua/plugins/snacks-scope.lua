return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    scope = {
      enabled = true,
      show_start = true,
      show_end = true,
      injected_languages = true,
      highlight = "Function",
      priority = 500,
    },
  },
  keys = {
    -- Scope navigation
    { "<leader>ss", function() require("snacks").scope.show() end, desc = "Show Scope" },
    { "<leader>sh", function() require("snacks").scope.hide() end, desc = "Hide Scope" },
    { "<leader>st", function() require("snacks").scope.toggle() end, desc = "Toggle Scope" },
  },
} 