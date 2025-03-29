return {
  "folke/snacks.nvim",
  opts = {
    lazygit = {},
  },
  keys = {
    {
      "<leader>go",
      function()
        require("snacks").lazygit()
      end,
      desc = "Git Lazy Git (open)",
    },
  },
}
