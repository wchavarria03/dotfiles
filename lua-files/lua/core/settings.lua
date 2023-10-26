-----------------------------------------------------------
-- Neovim settings
-----------------------------------------------------------

-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd                   -- execute Vim commands
local g = vim.g                       -- global variables
local opt = vim.opt                   -- global/buffer/windows-scoped options


-----------------------------------------------------------
-- General
-----------------------------------------------------------
g.mapleader = ','                     -- change leader to a comma
g.mapllocaleader = ','                -- change local leader to a comma
opt.timeoutlen = 500                  -- time waiting for key after leader key
opt.clipboard:append { 'unnamedplus' }-- copy/paste to system clipboard
opt.mouse = ''                        -- disable mouse

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.list = true                       -- Show some invisible characters
opt.number = true                     -- show line number
opt.showmatch = true                  -- highlight matching parenthesis
opt.foldmethod = 'indent'             -- enable folding (default 'foldmarker')
-- opt.foldcolumn = '1'               -- defines 1 col at window left, to indicate folding
opt.foldnestmax = 10	                -- maximum fold depth
opt.foldenable = true	                -- set to display all folds open
opt.foldlevel = 2	                    -- close folds with a level higher than this
-- opt.colorcolumn = '180'            -- line lenght marker at 80 columns
opt.splitright = true                 -- vertical split to the right
opt.splitbelow = true                 -- horizontal split to the bottom
opt.ignorecase = true                 -- ignore case letters when search
opt.smartcase = true                  -- ignore lowercase for the whole pattern
opt.scrolloff = 3                     -- minimum n# of lines above and below cursor
opt.relativenumber = true             -- Relative line numbers
opt.wildmode = {'list', 'longest', 'full'}    -- Command-line completion mode
opt.pumblend = 10                     -- transparency of pop-up menu
opt.pumheight = 8                     -- pop up menu height

-- remove whitespace on save
cmd[[au BufWritePre * :%s/\s\+$//e]]


-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true                     -- enable background buffers
opt.history = 100                     -- remember n lines in history
-- opt.lazyredraw = true                 -- faster scrolling
opt.synmaxcol = 240                   -- max column for syntax highlight
opt.wildignore:append { '*.pyc', '*.o', '*.obj', '.git', '*.rbc', '*.class' , '.svn','vendor/gems/*',
'*/node_modules/**', '*.mmdb', '*.dat', '*.sql', '*/coverage/**' }

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true                  -- use spaces instead of tabs
opt.shiftwidth = 2                    -- Size of an indent - 2 spaces when tab
opt.tabstop = 2                       -- Number of spaces tabs count for - 1 tab == 2 spaces
opt.softtabstop = 2	                  -- In insert mode, tabs are 2 spaces
opt.smartindent = true                -- Insert indents automatically

cmd [[set formatoptions=njtcroql]]

-- don't auto commenting new lines
cmd[[au BufEnter * set fo-=c fo-=r fo-=o]]

-- remove line lenght marker for selected filetypes
cmd[[autocmd FileType text,markdown,xml,html,xhtml,javascript setlocal cc=0]]

-- 2 spaces for selected filetypes
cmd[[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]]

-- IndentLine
g.indentLine_char = '|'               -- set indentLine character

-- disable IndentLine for markdown files (avoid concealing)
cmd[[autocmd FileType markdown let g:indentLine_enabled=0]]


-----------------------------------------------------------
-- Mist
-----------------------------------------------------------
opt.updatecount = 100                 -- Write swap file to disk every 100 chars
opt.autoread = true                   -- Reload files changed outside vim
