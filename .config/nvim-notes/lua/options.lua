-- Basic Neovim settings for notes

-- Editor appearance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

-- Text editing
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Text formatting
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Colors and display
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.titlestring = '%t - Notes'

-- Performance
vim.opt.lazyredraw = true
vim.opt.updatetime = 300

-- File handling
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load Tokyo Night colorscheme if available
local tokyonight_path = vim.fn.stdpath("data") .. "/site/pack/plugins/start/tokyonight.nvim"
if vim.fn.isdirectory(tokyonight_path) == 1 then
  vim.cmd('colorscheme tokyonight')
else
  -- Fallback to built-in high-contrast colorscheme
  vim.cmd('colorscheme slate')
end 