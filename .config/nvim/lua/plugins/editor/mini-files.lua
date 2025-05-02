return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",
  keys = {
    {
      "<leader>e",
      function()
        require("mini.files").open()
      end,
      desc = "Explorer Mini Files",
    },
  },
  config = function()
    require("mini.files").setup({})
  end,
}
