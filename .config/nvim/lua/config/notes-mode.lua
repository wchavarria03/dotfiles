-- Notes mode specific configurations
-- This file is loaded when vim.g.nvim_mode == "notes"

print('Notes mode')
-- Note-specific options that override main nvim config
vim.o.colorcolumn = "80" -- Show column guide for notes
vim.o.title = true -- Show title
vim.o.titlestring = '%t - Notes' -- Custom title format for notes

-- Note-specific indentation (2 spaces for markdown vs 4 in main)
vim.o.tabstop = 2 -- Number of spaces tabs count for (markdown standard)
vim.o.softtabstop = 2 -- Number of spaces tabs count for
vim.o.shiftwidth = 2 -- Size of an indent - 2 spaces for markdown

-- Note-specific text wrapping (enabled for notes vs disabled in main)
vim.o.wrap = true -- Enable line wrap for notes
vim.o.linebreak = true -- Wrap lines at convenient points
vim.o.breakindent = true -- Preserve indentation in wrapped lines
vim.o.showbreak = '↪ ' -- Show break indicator

-- Note-specific scroll context (more for notes)
vim.o.scrolloff = 8 -- Lines of context (more for notes)

-- Note-specific list characters (show invisible characters for markdown)
vim.o.list = true -- Show some invisible characters
vim.o.listchars = 'tab:▸ ,trail:·,extends:❯,precedes:❮,nbsp:·'

-- Markdown specific conceal settings
vim.o.conceallevel = 2
vim.o.concealcursor = 'nc'

-- Note-specific keymaps that extend main nvim config
-- Markdown-specific mappings (using existing leader>n prefix)
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

-- Note-specific keymaps using leader>n prefix (following main config format)
vim.keymap.set('n', '<leader>nh1', 'i# <Esc>', { desc = 'Header 1' })
vim.keymap.set('n', '<leader>nh2', 'i## <Esc>', { desc = 'Header 2' })
vim.keymap.set('n', '<leader>nh3', 'i### <Esc>', { desc = 'Header 3' })
vim.keymap.set('n', '<leader>nh4', 'i#### <Esc>', { desc = 'Header 4' })

-- Quick todo items (using existing leader>nt prefix)
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

-- Toggle markdown rendering
vim.keymap.set('n', '<leader>nm', function()
    local ok, render_markdown = pcall(require, 'render-markdown')
    if ok then
        render_markdown.toggle()
    end
end, { desc = 'Toggle markdown rendering' })

-- Enhanced markdown and text file specific settings (extends main config)
local function augroup(name)
    return vim.api.nvim_create_augroup('nvim_notes_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = augroup 'markdown_settings',
    pattern = { 'markdown', 'md', 'txt', 'text', 'gitcommit', 'plaintex', 'typst' },
    desc = 'Enhanced settings for markdown and text files in notes',
    callback = function()
        -- Note-specific indentation (2 spaces for markdown)
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
        
        -- Note-specific text wrapping
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.showbreak = '↪ '
        
        -- Note-specific spell checking
        vim.opt_local.spell = true
        vim.opt_local.conceallevel = 2
    end,
})

-- Auto-save notes on text changes
vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
    group = augroup 'auto_save',
    pattern = { '*.md', '*.txt', '*.markdown' },
    callback = function()
        if vim.bo.modified and vim.bo.buftype == '' then
            vim.cmd 'silent! write'
        end
    end,
}) 