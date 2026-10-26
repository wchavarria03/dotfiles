vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Move selected line / block of text in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line up', noremap = true, silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line down', noremap = true, silent = true })

-- Avoid Arrow Keys
vim.keymap.set('', '<up>', '<nop>', { desc = 'Global: Arrow up disabled' })
vim.keymap.set('', '<down>', '<nop>', { desc = 'Global: Arrow down disabled' })
vim.keymap.set('', '<left>', '<nop>', { desc = 'Global: Arrow left disabled' })
vim.keymap.set('', '<right>', '<nop>', { desc = 'Global: Arrow right disabled' })

-- Note: Window navigation (<C-h/j/k/l>) is handled by smart-splits plugin

-- Escape mapping
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Global: Escape' })
vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Global: Escape' })

-- Clear search highlighting
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', { desc = 'Global: Clear Selection', silent = true })

-- Next and previous result centered
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Scroll Down', noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Scroll Up', noremap = true, silent = true })

-- Scroll and keep cursor centered
vim.keymap.set('v', '<C-d>', '<C-d>zz', { desc = 'Scroll Down', noremap = true, silent = true })
vim.keymap.set('v', '<C-u>', '<C-u>zz', { desc = 'Scroll Up', noremap = true, silent = true })

-- keep highlight after indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Indent', noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent', noremap = true, silent = true })

-- Windows
vim.keymap.set('n', '<C-->', ':vsplit<CR>', { desc = 'Global: Window Split Vert' })
vim.keymap.set('n', '<C-\\>', ':split<CR>', { desc = 'Global: Window Split Hori' })

vim.keymap.set(
    'n',
    '<leader>ur',
    '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>',
    { desc = 'Redraw / Clear hlsearch / Diff Update' }
)

-- Pack management
vim.keymap.set('n', '<leader>pu', '<Cmd>PackUpdate<CR>', { desc = 'Pack update' })
vim.keymap.set('n', '<leader>pl', '<Cmd>PackList<CR>', { desc = 'Pack list' })
vim.keymap.set('n', '<leader>pc', '<Cmd>PackClean<CR>', { desc = 'Pack clean' })

