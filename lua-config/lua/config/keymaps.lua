local keymap = vim.keymap

-- clear search highlighting
keymap.set('n', '<leader>c', ':nohlsearch<CR>', { desc = 'Global: [C]lear Selection' })

-- Escape mappings
keymap.set('i', '<Esc>', '<Nop>', { desc = 'Global: Block Escape' })
keymap.set('i', 'jk', '<Esc>', { desc = 'Global: Escape' })

-- Remap for dealing with word wrap
keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Global: Block Escape', expr = true, silent = true })
keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Global: Block Escape', expr = true, silent = true })

-- increment / decrement
keymap.set('n', '+', '<C-a>', { desc = 'Global: Increment' })
keymap.set('n', '-', '<C-x>', { desc = 'Global: Decrement' })

-- Avoid Arrow Keys
keymap.set('', '<up>', '<nop>', { desc = 'Global: Arrow up disabled' })
keymap.set('', '<down>', '<nop>', { desc = 'Global: Arrow down disabled' })
keymap.set('', '<left>', '<nop>', { desc = 'Global: Arrow left disabled' })
keymap.set('', '<right>', '<nop>', { desc = 'Global: Arrow right disabled' })

-- Files
keymap.set({ 'i', 'x', 'n', 's' }, '<leader>sf', '<cmd>w<cr><esc>', { desc = 'Global: [S]ave [F]ile' })

-- Navigation
keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Global: Move Left Window' })
keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Global: Move Right Window' })
keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Global: Move Up Window' })
keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Global: Move Down Window' })

-- Resize window using <ctrl> arrow keys
keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Global: Increase Window Height' })
keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Global: Decrease Window Height' })
keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Global: Decrease Window Width' })
keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Global: Increase Window Width' })

-- Windows
keymap.set('n', '<C-v>', ':vsplit<CR>', { desc = 'Global: Window Split Vert' })
keymap.set('n', '<C-x>', ':split<CR>', { desc = 'Global: Window Split Hori' })
