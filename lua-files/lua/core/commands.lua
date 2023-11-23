local cmd = vim.cmd                   -- execute Vim commands
local opt = vim.opt                   -- global/buffer/windows-scoped options

opt.clipboard:append { 'unnamedplus' }-- copy/paste to system clipboard
-- '*/node_modules/**', '*.mmdb', '*.dat', '*.sql', '*/coverage/**' }

-- remove whitespace on save
cmd[[au BufWritePre * :%s/\s\+$//e]]

cmd[[set formatoptions=njtcroql]]

-- don't auto commenting new lines
cmd[[au BufEnter * set fo-=c fo-=r fo-=o]]

-- remove line lenght marker for selected filetypes
cmd[[autocmd FileType text,markdown,xml,html,xhtml,javascript setlocal cc=0]]

cmd[[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
  augroup END
]]

