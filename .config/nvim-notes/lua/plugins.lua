-- Plugin management with lazy.nvim for notes config

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end

-- Add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim with individual plugin files
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = 'plugins/colorscheme' },
    { import = 'plugins/snacks' },
    { import = 'plugins/snacks-git' },
    { import = 'plugins/snacks-gitbrowser' },
    { import = 'plugins/snacks-buffer' },
    { import = 'plugins/snacks-input' },
    { import = 'plugins/snacks-scope' },
    { import = 'plugins/image' },
    { import = 'plugins/git' },
    { import = 'plugins/ui' },
    { import = 'plugins/treesitter' },
    { import = 'plugins/markdown' },
    { import = 'plugins/editor' },
    { import = 'plugins/linting' },
    { import = 'plugins/formatting' },
  },
  root = vim.fn.stdpath("data") .. "/lazy",
  lockfile = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json",
}) 