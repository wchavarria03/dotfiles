local opt = vim.opt                   -- global/buffer/windows-scoped options

opt.syntax = "ON"
opt.cursorline = true                 -- Highlight cursor line
opt.termguicolors = true              -- enable 24-bit RGB colors

opt.pumblend = 5                      -- pseudo-transparency for the popup-menu

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd [[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
  augroup END
]]

