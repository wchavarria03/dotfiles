-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim and plugins.
-----------------------------------------------------------
local bufmap = function(mode, lhs, rhs, desc, opts)
  local local_opts = { noremap = true, silent = true, desc = 'Keymaps: ' .. desc }
  vim.keymap.set(mode, lhs, rhs, local_opts)
end

-- clear search highlighting
bufmap('n', '<leader>c', ':nohl<CR>', 'Clear Selection')
bufmap('n', '<Esc>', ':nohl<CR>', 'Clear Selection')

-- increment / decrement
bufmap('n', '+', '<C-a>', 'Increment')
bufmap('n', '-', '<C-x>', 'Decrement')

-- Avoid Arrow Keys
bufmap('', '<up>', '<nop>', 'Arrow up disabled')
bufmap('', '<down>', '<nop>', 'Arrow down disabled')
bufmap('', '<left>', '<nop>', 'Arrow left disabled')
bufmap('', '<right>', '<nop>', 'Arrow right disabled')

-- Files
bufmap('n', '<leader>s', ':w<CR>', 'Save File')
bufmap('i', '<leader>s', '<C-c>:w<CR>', 'Save File')

-- Navigation
bufmap('n', '<C-h>', '<C-w>h', 'Move Left Window')
bufmap('n', '<C-j>', '<C-w>j', 'Move Right Window')
bufmap('n', '<C-k>', '<C-w>k', 'Move Up Window')
bufmap('n', '<C-l>', '<C-w>l', 'Move Down Window')

-- Buffers
bufmap('n', '<leader>bd', ':bd<CR>', 'Buffer Delete')
bufmap('n', '<leader>bn', ':bnext<CR>', 'Buffer Next')
bufmap('n', '<leader>bp', ':bprevious<CR>', 'Buffer Prev')

-- Windows
bufmap('n', '<leader>q', ':quitall<CR>', 'Close All Windows')
bufmap('n', '<C-v>', ':vsplit<CR>', 'Window Split Vert')
bufmap('n', '<C-x>', ':split<CR>', 'Window Split Hori')