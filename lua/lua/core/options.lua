local options = {
  -- Insert indents automatically
  smartindent = true,
  -- Number of spaces tabs count for - 1 tab == 2 spaces
  tabstop = 1,
  -- Size of an indent - 2 spaces when tab
  shiftwidth = 2,
  -- use spaces instead of tabs
  expandtab = true,
  -- In insert mode, tabs are 2 spaces
  softtabstop = 2,
  -- Always show tabs
  showtabline = 2,

  -- show line number
  number = true,
  -- Relative line numbers
  relativenumber = true,
  -- ignore case letters when search
  ignorecase = true,
  -- ignore lowercase for the whole pattern
  smartcase = true,

  -- vertical split to the right
  splitright = true,
  -- horizontal split to the bottom
  splitbelow = true,

  -- syntax highlight
  syntax = 'ON',
  -- enable 24-bit RGB colors
  termguicolors = true,
  -- always show the sign column
  signcolumn = 'yes',
  -- don't show mode
  showmode = false,
  -- disable line wrap
  wrap = false,
  -- Highlight cursor line
  cursorline = true,
  -- set file encoding to utf-8
  fileencoding = 'utf-8',

  -- enable folding (default 'foldmarker')
  foldmethod = 'indent',

  -- maximum fold depth
  foldnestmax = 10,
  -- close folds with a level higher than this
  foldlevel = 2,

  -- Show concealed text
  conceallevel = 1,

  -- wildmode = {'list', 'longest', 'full'},    -- Command-line completion mode
  -- wildoptions = 'pum',                       -- vertical wildmenu

  -- disable backup
  backup = true,
  -- set backupdir
  backupdir = vim.fn.expand '~/.config/nvim/backupdir',

  -- Write swap file to disk every 100 chars
  updatecount = 200,
  -- set directory
  directory = vim.fn.expand '~/.config/nvim/swap',

  -- enable undofile
  undofile = true,
  -- set undodir
  undodir = vim.fn.expand '~/.config/nvim/undodir',

  -- remember n lines in history
  history = 100,

  -- faster completion
  updatetime = 200,
  -- minimum n# of lines above and below cursor
  scrolloff = 15,
  -- disable mouse
  mouse = '',

  -- max column for syntax highlight
  synmaxcol = 200,

  -- Show some invisible characters
  list = true,
  listchars = {
    tab = '» ',
    leadmultispace = '┊ ',
    trail = '␣',
    space = '·',
    nbsp = '⍽',
  },
  showmatch = true, -- highlight matching parenthesis

  -- copy/paste to system clipboard'
  clipboard = 'unnamedplus',

  -- completion options
  completeopt = 'menuone,noinsert,noselect',
}

-- don't pass messages to |ins-completion-menu
vim.opt.shortmess:append 'c'

for option, value in pairs(options) do
  vim.opt[option] = value
end
