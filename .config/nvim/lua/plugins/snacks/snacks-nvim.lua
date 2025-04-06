return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dim = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
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
    { "<leader>[b", "<cmd>bnext<cr>",     desc = "Next Buffer", },
    { "<leader>]b", "<cmd>bprevious<cr>", desc = "Previous Buffer", },
    { "<leader>bb", "<cmd>e #<cr>",       desc = "Switch to Other Buffer" },
    { "<leader>bD", "<cmd>:bd<cr>",       desc = "Delete Buffer and Window" },
  },
}
