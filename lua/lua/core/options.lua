local options = {
  smartindent = true,                        -- Insert indents automatically
  tabstop = 2,                               -- Number of spaces tabs count for - 1 tab == 2 spaces
  shiftwidth = 2,                            -- Size of an indent - 2 spaces when tab
  expandtab = true,                          -- use spaces instead of tabs
  softtabstop = 2,	                         -- In insert mode, tabs are 2 spaces
  showtabline = 2,                           -- Always show tabs

  number = true,                             -- show line number
  relativenumber = true,                     -- Relative line numbers
  ignorecase = true,                         -- ignore case letters when search
  smartcase = true,                          -- ignore lowercase for the whole pattern

  splitright = true,                         -- vertical split to the right
  splitbelow = true,                         -- horizontal split to the bottom

  syntax = 'ON',                             -- syntax highlight
  termguicolors = true,                      -- enable 24-bit RGB colors
  signcolumn = 'yes',                        -- always show the sign column
  showmode = false,                          -- don't show mode
  wrap = false,                              -- disable line wrap
  cursorline = false,                        -- Highlight cursor line
  fileencoding = 'utf-8',                    -- set file encoding to utf-8

  foldmethod = 'indent',                     -- enable folding (default 'foldmarker')
  -- opt.foldcolumn = '1'                    -- defines 1 col at window left, to indicate folding
  foldnestmax = 10,	                         -- maximum fold depth
  foldlevel = 2,	                           -- close folds with a level higher than this

 -- wildmode = {'list', 'longest', 'full'},    -- Command-line completion mode
 -- wildoptions = 'pum',                       -- vertical wildmenu

  backup = true,                             -- disable backup
  backupdir = vim.fn.expand('~/.config/nvim/backupdir'),    -- set backupdir

  updatecount = 200,                         -- Write swap file to disk every 100 chars
  directory = vim.fn.expand('~/.config/nvim/swap'),         -- set directory

  undofile = true,                           -- enable undofile
  undodir = vim.fn.expand('~/.config/nvim/undodir'),        -- set undodir

  history = 100,                             -- remember n lines in history

  updatetime = 200,                          -- faster completion
  scrolloff = 15,                            -- minimum n# of lines above and below cursor
  mouse = '',                                -- disable mouse

  synmaxcol = 200,                           -- max column for syntax highlight

  list = true,                       -- Show some invisible characters
  listchars = {
    tab = "⇥ ",
    leadmultispace = "┊ ",
    trail = "␣",
    space = "·",
    nbsp = "⍽"
  },
  showmatch = true,                  -- highlight matching parenthesis

  title = true,                              -- set title
  titlestring = "NVIM - %t",                 -- set titlestring
  guifont = "MesloLGS NF:h18",               -- set font

  clipboard = 'unnamedplus'                  -- copy/paste to system clipboard'
}

vim.opt.shortmess:append('c')                -- don't pass messages to |ins-completion-menu

for option, value in pairs(options) do
  vim.opt[option] = value
end
