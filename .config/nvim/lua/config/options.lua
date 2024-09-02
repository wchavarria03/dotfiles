-- Insert indents automatically
vim.opt.smartindent = true
--
vim.opt.shiftround = true -- Round indent
-- Number of spaces tabs count for - 1 tab == 2 spaces
vim.opt.tabstop = 4
-- Size of an indent - 2 spaces when tab
vim.opt.shiftwidth = 4
-- use spaces instead of tabs
vim.opt.expandtab = true
-- In insert mode tabs are 2 spaces
vim.opt.softtabstop = 4
-- Always show tabs
vim.opt.showtabline = 2

-- show line number
vim.opt.number = true
-- Relative line numbers
vim.opt.relativenumber = true
-- ignore case letters when search
vim.opt.ignorecase = true
-- ignore lowercase for the whole pattern
vim.opt.smartcase = true

-- vertical split to the right
vim.opt.splitright = true
-- horizontal split to the bottom
vim.opt.splitbelow = true
vim.opt.splitkeep = 'screen'

-- syntax highlight
vim.opt.syntax = 'ON'
-- enable 24-bit RGB colors
vim.opt.termguicolors = true
-- always show the sign column
vim.opt.signcolumn = 'yes'
-- don't show mode
vim.opt.showmode = false
-- disable line wrap
vim.opt.wrap = false
-- Highlight cursor line
vim.opt.cursorline = true
-- set file encoding to utf-8
vim.opt.fileencoding = 'utf-8'

-- enable folding (default 'foldmarker')
vim.opt.foldmethod = 'indent'
-- maximum fold depth
vim.opt.foldnestmax = 10
-- close folds with a level higher than this
vim.opt.foldlevel = 5
-- Show concealed text
vim.opt.conceallevel = 1
vim.opt.foldtext = ''

-- Confirm actions
vim.opt.confirm = true

vim.opt.wildmode = 'longest:full,full' -- Command-line completion mode
-- wildoptions = 'pum'                      -- vertical wildmenu

-- disable backup
vim.opt.backup = true
-- set backupdir
vim.opt.backupdir = vim.fn.expand('~/.config/nvim/backupdir')

-- Write swap file to disk every 100 chars
vim.opt.updatecount = 200
-- set directory
vim.opt.directory = vim.fn.expand('~/.config/nvim/swap')

-- enable undofile
vim.opt.undofile = true
-- set undodir
vim.opt.undodir = vim.fn.expand('~/.config/nvim/undodir')
vim.opt.undolevels = 10000

-- remember n lines in history
vim.opt.history = 100

-- faster completion
vim.opt.updatetime = 200
-- minimum n# of lines above and below cursor
vim.opt.scrolloff = 15
vim.opt.smoothscroll = true
-- disable mouse
vim.opt.virtualedit = 'block'
vim.opt.mouse = ''
vim.opt.timeoutlen = 300

-- max column for syntax highlight
vim.opt.synmaxcol = 200

-- Show some invisible characters
vim.opt.list = true
vim.opt.listchars = {
	tab = '» ',
	leadmultispace = '┊ ',
	trail = '␣',
	space = '·',
	nbsp = '⍽',
}
vim.opt.fillchars = {
	foldopen = '',
	foldclose = '',
	fold = ' ',
	foldsep = ' ',
	diff = '╱',
	eob = ' ',
}
vim.opt.showmatch = true -- highlight matching parenthesis

-- copy/paste to system clipboard'
vim.opt.clipboard = 'unnamedplus'

-- completion options
vim.opt.completeopt = 'menu,menuone,noselect,noinsert'

vim.opt.cmdheight = 2
vim.opt.winminwidth = 5
vim.opt.formatoptions = 'jcroqlnt'
vim.opt.jumpoptions = 'view'

-- Popup blen
vim.opt.pumblend = 10
-- Maximum number of entries in a popup
vim.opt.pumheight = 10

-- don't pass messages to |ins-completion-menu
-- Maximum number of entries in a popup
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.spelloptions:append('noplainbuffer')
