-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim and plugins.
-----------------------------------------------------------

local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- clear search highlighting
map('n', '<leader>c', ':nohl<CR>', default_opts)

-- increment / decrement
map('n', '+', '<C-a>', {noremap = true})
map('n', '-', '<C-x>', {noremap = true})

-- don't use arrow keys
map('', '<up>', '<nop>', {noremap = true})
map('', '<down>', '<nop>', {noremap = true})
map('', '<left>', '<nop>', {noremap = true})
map('', '<right>', '<nop>', {noremap = true})

-- fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>', default_opts)
map('i', '<leader>s', '<C-c>:w<CR>', default_opts)

-- Navigation
map('n', '<C-h>', '<C-w>h', default_opts)
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)

-- close all windows and exit from neovim
map('n', '<leader>q', ':quitall<CR>', default_opts)

-- Buffers
map('n', '<leader>bd', ':bd<CR>', default_opts)
map("n", "<tab>", ":bnext<CR>", default_opts) -- Next Tab
map("n", "<s-tab>", ":bprevious<CR>", default_opts) -- Previous tab

-- Windows
map("n", "<C-v>", ":vsplit<CR>", default_opts) -- Previous tab
map("n", "<C-x>", ":split<CR>", default_opts) -- Previous tab
