vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Move selected line / block of text in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line up', noremap = true, silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line down', noremap = true, silent = true })

-- Buffers navigation
vim.keymap.set('n', '<C-k>', '<C-w><up>', { desc = 'Move Up', expr = true, silent = true })
vim.keymap.set('n', '<C-h>', '<C-w><left>', { desc = 'Move Left', expr = true, silent = true })

-- Avoid Arrow Keys
vim.keymap.set('', '<up>', '<nop>', { desc = 'Global: Arrow up disabled' })
vim.keymap.set('', '<down>', '<nop>', { desc = 'Global: Arrow down disabled' })
vim.keymap.set('', '<left>', '<nop>', { desc = 'Global: Arrow left disabled' })
vim.keymap.set('', '<right>', '<nop>', { desc = 'Global: Arrow right disabled' })

-- Navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Global: Move Left Window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Global: Move Right Window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Global: Move Up Window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Global: Move Down Window' })

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
vim.keymap.set('n', '<C-\\>', ':split<CR>', { desc = 'Global: Window Split Hori' })

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C->', '<cmd>resize +5<cr>', { desc = 'Global: Increase Window Height' })
vim.keymap.set('n', '<C->', '<cmd>resize -5<cr>', { desc = 'Global: Decrease Window Height' })
vim.keymap.set('n', '<C-<>', '<cmd>vertical resize -5<cr>', { desc = 'Global: Decrease Window Width' })
vim.keymap.set('n', '<C->>', '<cmd>vertical resize +5<cr>', { desc = 'Global: Increase Window Width' })

vim.keymap.set(
    'n',
    '<leader>tr',
    '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>',
    { desc = 'Redraw / Clear hlsearch / Diff Update' }
)

vim.schedule(function()
    local ok, snacks = pcall(require, 'snacks')
    if ok then
        snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
        snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
        snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>tL'
        snacks.toggle.diagnostics():map '<leader>td'
        snacks.toggle.line_number():map '<leader>tl'
        snacks.toggle
            .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = 'Conceal Level' })
            :map '<leader>tc'
        snacks.toggle.treesitter():map '<leader>tT'
        snacks.toggle.dim():map '<leader>tD'
        snacks.toggle.animate():map '<leader>ta'
        snacks.toggle.indent():map '<leader>ti'
        snacks.toggle.scroll():map '<leader>tS'

        if vim.lsp.inlay_hint then
            snacks.toggle.inlay_hints():map '<leader>th'
        end
        snacks.toggle.zoom():map '<leader>tZ'
        snacks.toggle.zen():map '<leader>tz'

        snacks
            .toggle({
                name = 'Mini Pairs',
                get = function()
                    return not vim.g.minipairs_disable
                end,
                set = function(state)
                    vim.g.minipairs_disable = not state
                end,
            })
            :map '<leader>tp'

        snacks.toggle
            .new({
                id = 'Format on Save',
                name = 'Format on Save',
                get = function()
                    return vim.g.autoformat
                end,
                set = function(_)
                    vim.g.autoformat = not vim.g.autoformat
                end,
            })
            :map '<leader>tf'

        snacks.toggle
            .new({
                id = 'HardTime',
                name = 'HardTime',
                get = function()
                    return vim.g.hardtime
                end,
                set = function(_)
                    vim.cmd 'Hardtime toggle'
                    vim.g.hardtime = not vim.g.hardtime
                end,
            })
            :map '<leader>th'
    end
end)

-- -- Clear search and close snippet
-- vim.keymap.set({ "i", "n", "s" }, "<esc>", function()
--   vim.cmd("noh")
--
--   -- TODO: Test if this is working as expected
--   if require("luasnip").expand_or_jumpable() then
--     require("luasnip").unlink_current()
--     return true
--   end
--
--   return "<esc>"
-- end, { expr = true, desc = "Escape and Clear hlsearch" })

-- Save/Write file
-- vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Markdown mappings
vim.keymap.set('i', '<C-b>', '****<Left><Left>', { desc = 'Bold Text' })
vim.keymap.set('i', '<C-i>', '**<Left>', { desc = 'Italic Text' })
vim.keymap.set('i', '<C-k>', '`<Left>', { desc = 'Inline Code' })
vim.keymap.set('i', '<C-l>', '[]()<Left><Left><Left>', { desc = 'Link' })
vim.keymap.set('i', '<C-u>', '~~<Left>', { desc = 'Strikethrough' })

-- Visual mode markdown formatting (wrap selected text)
vim.keymap.set('v', '<C-b>', 'c****<Esc>P', { desc = 'Bold Selected Text' })
vim.keymap.set('v', '<C-i>', 'c**<Esc>P', { desc = 'Italic Selected Text' })
vim.keymap.set('v', '<C-k>', 'c`<Esc>P', { desc = 'Inline Code Selected Text' })
vim.keymap.set('v', '<C-u>', 'c~~<Esc>P', { desc = 'Strikethrough Selected Text' })

-- Quick list items
vim.keymap.set('i', '<C-o>', '- ', { desc = 'Unordered List Item' })
vim.keymap.set('i', '<C-n>', '1. ', { desc = 'Ordered List Item' })

-- Note-specific keymaps using leader>n prefix
vim.keymap.set('n', '<leader>nh1', 'i# <Esc>', { desc = 'Header 1' })
vim.keymap.set('n', '<leader>nh2', 'i## <Esc>', { desc = 'Header 2' })
vim.keymap.set('n', '<leader>nh3', 'i### <Esc>', { desc = 'Header 3' })
vim.keymap.set('n', '<leader>nh4', 'i#### <Esc>', { desc = 'Header 4' })

-- Quick todo items
vim.keymap.set('n', '<leader>ntt', 'i- [ ] <Esc>', { desc = 'Add Todo Item' })
vim.keymap.set('n', '<leader>ntd', 'i- [x] <Esc>', { desc = 'Add Done Item' })

-- Quick code blocks
vim.keymap.set('n', '<leader>ncb', 'i```<CR><CR>```<Up>', { desc = 'Code Block' })
vim.keymap.set('n', '<leader>nci', 'i`<Esc>', { desc = 'Inline Code' })

-- Quick quotes
vim.keymap.set('n', '<leader>nq', 'i> <Esc>', { desc = 'Quote Block' })

-- Quick horizontal rule
vim.keymap.set('n', '<leader>nhr', 'i---<CR>', { desc = 'Horizontal Rule' })

-- Note navigation
vim.keymap.set('n', '<leader>no', '<cmd>e ~/Library/Mobile\\ Documents/com~apple~CloudDocs/notes/<cr>', { desc = 'Open notes folder' })

-- Zen mode for focused writing
vim.keymap.set('n', '<leader>nz', '<cmd>ZenMode<cr>', { desc = 'Toggle zen mode' })
