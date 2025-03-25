return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    notifier = {
      enabled = true,
      timeout = 3000,
    },
  },
  keys = {
    {
      "<leader>sn",
      function()
        require("snacks").notifier.show_history()
      end,
      desc = "Notifier Htory",
    },
  },
}
