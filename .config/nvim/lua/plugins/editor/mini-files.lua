return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",
  keys = {
    {
      "<leader>e",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Explorer Mini Files",
    },
    {
      "<leader>E",
      function()
        require("mini.files").open()
      end,
      desc = "Explorer Mini Files (Current Directory)",
    },
  },
  opts = {
    options = {
      parmanent_delete = false,
      use_as_default_explorer = true,
    },
  },
  config = function(_, opts)
    require("mini.files").setup(opts)
  end,
}
