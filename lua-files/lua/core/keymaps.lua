-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim and plugins.
-----------------------------------------------------------
local bufmap = function(mode, lhs, rhs, desc, opts)
  local local_opts = { noremap = true, silent = true, desc = 'Keymaps: ' .. desc }
  vim.keymap.set(mode, lhs, rhs, local_opts)
end

-- clear search highlighting
bufmap('n', '<leader>c', ':nohl<CR>', 'Clear Selection')
-- Escape mappings
bufmap('i', '<Esc>', '<Nop>', 'Block Escape')
bufmap('i', 'jk', '<Esc>', 'Escape')

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

-- Windows
bufmap('n', '<C-v>', ':vsplit<CR>', 'Window Split Vert')
bufmap('n', '<C-x>', ':split<CR>', 'Window Split Hori')
