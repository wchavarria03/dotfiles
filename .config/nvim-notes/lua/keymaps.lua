-- Keymaps for notes

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic file operations
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>wq', ':wq<CR>', { desc = 'Save and quit' })
vim.keymap.set('n', '<leader>Q', ':q!<CR>', { desc = 'Quit without saving' })

-- Navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Window management
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { desc = 'Split vertically' })
vim.keymap.set('n', '<leader>sh', ':split<CR>', { desc = 'Split horizontally' })
vim.keymap.set('n', '<leader>sc', ':close<CR>', { desc = 'Close window' })

-- Search and replace
vim.keymap.set('n', '<leader>s', ':%s/', { desc = 'Search and replace' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result centered' })

-- Text editing
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', { desc = 'Move line down' })
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', { desc = 'Move line up' })
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up centered' })

-- Linting
vim.keymap.set('n', '<leader>ll', ':lua require("lint").try_lint()<CR>', { desc = 'Lint current file' })
vim.keymap.set('n', '<leader>ln', ':lua require("lint").try_lint("markdownlint")<CR>', { desc = 'Lint with markdownlint' })
vim.keymap.set('n', '<leader>ls', ':lua require("lint").try_lint("cspell")<CR>', { desc = 'Lint with cspell' })

-- Formatting
vim.keymap.set('n', '<leader>cf', ':lua require("conform").format()<CR>', { desc = 'Format buffer' })
vim.keymap.set('n', '<leader>cF', ':lua require("conform").format({ formatters = { "injected" } })<CR>', { desc = 'Format injected languages' })

-- Markdown-specific keymaps (will be set in autocmds)
local function setup_markdown_keymaps()
  vim.keymap.set('n', '<leader>mp', ':MarkdownPreviewToggle<CR>', { 
    desc = 'Toggle markdown preview', 
    buffer = true 
  })
  vim.keymap.set('n', '<leader>ms', ':MarkdownPreviewStop<CR>', { 
    desc = 'Stop markdown preview', 
    buffer = true 
  })
  vim.keymap.set('n', '<leader>mr', ':MarkdownPreview<CR>', { 
    desc = 'Start markdown preview', 
    buffer = true 
  })
  
  -- Table mode
  vim.keymap.set('n', '<leader>mt', ':TableModeToggle<CR>', { 
    desc = 'Toggle table mode', 
    buffer = true 
  })
  
  -- Generate table of contents
  vim.keymap.set('n', '<leader>mc', ':GenTocGFM<CR>', { 
    desc = 'Generate table of contents', 
    buffer = true 
  })
  
  -- Update table of contents
  vim.keymap.set('n', '<leader>mu', ':UpdateToc<CR>', { 
    desc = 'Update table of contents', 
    buffer = true 
  })
end

-- Export for use in autocmds
_G.setup_markdown_keymaps = setup_markdown_keymaps 