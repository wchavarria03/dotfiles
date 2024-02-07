return {
  {
    "knubie/vim-kitty-navigator",
    config = function()
      vim.fn.system('cp ./*.py ~/.config/kitty/')
    end,
  }
}

