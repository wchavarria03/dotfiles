return {
  "folke/zen-mode.nvim",
  event = "VeryLazy",
  opts = {
    -- Enhanced zen configuration for focused writing
    window = {
      width = 120,
      options = {
        number = false,
        relativenumber = false,
        signcolumn = "no",
        foldcolumn = "0",
        list = false,
      },
    },
    plugins = {
      options = {
        enabled = true,
        ruler = false,
        showcmd = false,
        laststatus = 0,
      },
      twilight = { enabled = true },
    },
  },
}
