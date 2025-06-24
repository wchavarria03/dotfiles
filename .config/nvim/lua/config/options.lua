vim.o.number = true -- show line number
vim.o.relativenumber = true -- Relative line numbers

vim.o.tabstop = 4 -- Number of spaces tabs count for
vim.o.softtabstop = 4 -- Number of spaces tabs count for
vim.o.shiftwidth = 4 -- Size of an indent - 4 spaces when tab
vim.o.shiftround = true -- Round indent
vim.o.expandtab = true -- use spaces instead of tabs
vim.o.wrap = false -- Disable line wrap
vim.o.autoindent = true -- Auto indent new lines
vim.o.smartindent = true -- Insert indents automatically

vim.o.swapfile = false -- Don't use swapfile
vim.o.undofile = true
vim.o.undolevels = 10000

vim.o.ignorecase = true -- ignore case letters when search
vim.o.smartcase = true -- Don't ignore case with capitals
vim.o.inccommand = 'nosplit' -- preview incremental substitute

vim.o.termguicolors = true -- True color support
vim.o.scrolloff = 4 -- Lines of context
vim.o.signcolumn = 'yes' -- always show the sign column

vim.o.splitright = true -- Put new windows right of current
vim.o.splitbelow = true -- Put new windows below current

vim.o.updatetime = 50

vim.o.clipboard = 'unnamedplus' -- copy/paste to system clipboard'

vim.o.mouse = '' -- disable mouse

-- Other pending to organize in groups
vim.o.completeopt = 'menu,menuone,popup,noselect'
vim.o.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
vim.o.confirm = true -- Confirm to save changes before exiting modified buffer
vim.o.cursorline = true -- Highlight cursor line
vim.o.foldlevel = 99 -- close folds with a level higher than this
vim.o.foldmethod = 'indent'
vim.o.formatoptions = 'jcroqlnt'
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.grepprg = 'rg --vimgrep'
vim.o.jumpoptions = 'view'
vim.o.laststatus = 3 -- global statusline
vim.o.linebreak = true -- Wrap lines at convenient points
vim.o.pumblend = 15 -- Pop-up blend
vim.o.ruler = false -- Disable the default ruler
vim.o.showmode = false -- Don't show mode since we have a statusline
vim.o.sidescrolloff = 8 -- Columns of context
vim.o.spell = true
vim.o.spelllang = 'en'
vim.o.splitbelow = true -- Put new windows below current
vim.o.splitkeep = 'screen'
vim.o.timeoutlen = 300 -- Lower than default (1000) to quickly trigger which-key
vim.o.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
vim.o.wildmode = 'longest:full,full' -- Command-line completion mode
vim.o.winborder = 'rounded'
vim.o.winminwidth = 5 -- Minimum window width

-- TO BE Tested
vim.o.list = true -- Show some invisible characters
