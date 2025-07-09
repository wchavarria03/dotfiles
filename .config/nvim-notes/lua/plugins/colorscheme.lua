return {
  -- Tokyo Night colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.tokyonight_style = "storm"
      vim.g.tokyonight_transparent = false
      vim.g.tokyonight_terminal_colors = true
      vim.cmd.colorscheme("tokyonight")
    end,
  },
} 