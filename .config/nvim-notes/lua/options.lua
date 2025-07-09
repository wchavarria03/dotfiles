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

-- Essential settings from regular nvim config
vim.opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
vim.opt.completeopt = 'menu,menuone,popup,noselect'
vim.opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.foldlevel = 99 -- close folds with a level higher than this
vim.opt.foldmethod = 'indent'
vim.opt.formatoptions = 'jcroqlnt'
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.jumpoptions = 'view'
vim.opt.laststatus = 3 -- global statusline
vim.opt.pumblend = 15 -- Pop-up blend
vim.opt.ruler = false -- Disable the default ruler
vim.opt.showmode = false -- Don't show mode since we have a statusline
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.spell = true
vim.opt.spelllang = 'en'
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitkeep = 'screen'
vim.opt.timeoutlen = 300 -- Lower than default (1000) to quickly trigger which-key
vim.opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
vim.opt.wildmode = 'longest:full,full' -- Command-line completion mode
vim.opt.winborder = 'rounded'
vim.opt.winminwidth = 5 -- Minimum window width

-- Performance optimizations
vim.opt.history = 1000 -- Increase command history
vim.opt.shada = '!,\'1000,<50,s10,h' -- Increase shada history
vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions' -- Session options
vim.opt.viewoptions = 'cursor,folds,slash,unix' -- View options
vim.opt.viminfo = '!,\'1000,<50,s10,h' -- Viminfo options

-- Load Tokyo Night colorscheme if available
local tokyonight_path = vim.fn.stdpath("data") .. "/site/pack/plugins/start/tokyonight.nvim"
if vim.fn.isdirectory(tokyonight_path) == 1 then
  vim.cmd('colorscheme tokyonight')
else
  -- Fallback to built-in high-contrast colorscheme
  vim.cmd('colorscheme slate')
end 