return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    gitbrowse = {
      enabled = true,
    },
  },
  keys = {
    {
      "<leader>gB",
      function()
        require("snacks").gitbrowse()
      end,
      desc = "Git Browse (open)",
    },
    {
      "<leader>gY",
      function()
        require("snacks").gitbrowse({
          open = function(url)
            vim.fn.setreg("+", url)
          end,
          notify = false,
        })
      end,
      desc = "Git Browse (copy)",
    },
  },
}
