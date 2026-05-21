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


-- Load notes functions
local notes = require 'utils.notes'

-- Markdown formatting (using leader>n prefix)
vim.keymap.set('i', '<leader>nb', '****<Left><Left>', { desc = 'Bold Text' })
vim.keymap.set('i', '<leader>ni', '**<Left>', { desc = 'Italic Text' })
vim.keymap.set('i', '<leader>nk', '`<Left>', { desc = 'Inline Code' })
vim.keymap.set('i', '<leader>na', '[]()<Left><Left><Left>', { desc = 'Link' })
vim.keymap.set('i', '<leader>ns', '~~<Left>', { desc = 'Strikethrough' })

-- Visual mode markdown formatting (wrap selected text)
vim.keymap.set('v', '<leader>nb', notes.format_bold, { desc = 'Bold Selected Text' })
vim.keymap.set('v', '<leader>ni', notes.format_italic, { desc = 'Italic Selected Text' })
vim.keymap.set('v', '<leader>nk', notes.format_code, { desc = 'Inline Code Selected Text' })
vim.keymap.set('v', '<leader>ns', notes.format_strikethrough, { desc = 'Strikethrough Selected Text' })

-- Quick list items (using leader>n prefix)
vim.keymap.set('i', '<leader>nl', notes.insert_unordered_list, { desc = 'Unordered List Item' })
vim.keymap.set('i', '<leader>n1', notes.insert_ordered_list, { desc = 'Ordered List Item' })

-- Note-specific keymaps using leader>n prefix
vim.keymap.set('n', '<leader>nh1', function()
    notes.insert_header(1)
end, { desc = 'Header 1' })
vim.keymap.set('n', '<leader>nh2', function()
    notes.insert_header(2)
end, { desc = 'Header 2' })
vim.keymap.set('n', '<leader>nh3', function()
    notes.insert_header(3)
end, { desc = 'Header 3' })
vim.keymap.set('n', '<leader>nh4', function()
    notes.insert_header(4)
end, { desc = 'Header 4' })

-- Quick todo items (smart checkbox handling)
vim.keymap.set('n', '<leader>ntt', notes.toggle_todo, { desc = 'Add/Toggle Todo Item' })
vim.keymap.set('n', '<leader>ntd', notes.toggle_done, { desc = 'Add/Toggle Done Item' })

-- Quick code blocks
vim.keymap.set('n', '<leader>ncb', notes.insert_code_block, { desc = 'Code Block' })
vim.keymap.set('n', '<leader>nci', notes.insert_inline_code, { desc = 'Inline Code' })

-- Quick quotes
vim.keymap.set('n', '<leader>nq', notes.insert_quote, { desc = 'Quote Block' })

-- Quick horizontal rule
vim.keymap.set('n', '<leader>nhr', notes.insert_horizontal_rule, { desc = 'Horizontal Rule' })

-- Note navigation
vim.keymap.set('n', '<leader>no', notes.open_notes_folder, { desc = 'Open notes folder' })

