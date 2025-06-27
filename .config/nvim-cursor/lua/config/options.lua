-- Essential editing options
vim.o.number = true
vim.o.relativenumber = true

-- Indentation
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.shiftround = true
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

-- File handling
vim.o.swapfile = false
vim.o.undofile = true
vim.o.undolevels = 10000

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'nosplit'

-- Display
vim.o.scrolloff = 4
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.sidescrolloff = 8

-- Performance
vim.o.updatetime = 50

-- Clipboard
vim.o.clipboard = 'unnamedplus'

-- Completion
vim.o.completeopt = 'menu,menuone,popup,noselect'

-- Behavior
vim.o.confirm = true
vim.o.timeoutlen = 300
vim.o.virtualedit = 'block'
vim.o.wildmode = 'longest:full,full'

-- VS Code compatible options only
vim.o.wrap = false
vim.o.conceallevel = 2
vim.o.formatoptions = 'jcroqlnt'
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.grepprg = 'rg --vimgrep'
vim.o.jumpoptions = 'view'
vim.o.linebreak = true
vim.o.spell = true
vim.o.spelllang = 'en'

-- Disable auto-commenting
vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]] 