-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
-- and plugins.
-----------------------------------------------------------

local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-----------------------------------------------------------
-- Neovim shortcuts:
-----------------------------------------------------------

-- clear search highlighting
map('n', '<leader>c', ':nohl<CR>', default_opts)

-- don't use arrow keys
map('', '<up>', '<nop>', {noremap = true})
map('', '<down>', '<nop>', {noremap = true})
map('', '<left>', '<nop>', {noremap = true})
map('', '<right>', '<nop>', {noremap = true})

-- fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>', default_opts)
map('i', '<leader>s', '<C-c>:w<CR>', default_opts)

-- Tab Change
map('n', '<C-h>', '<C-w>h', default_opts)
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)

-- close all windows and exit from neovim
map('n', '<leader>q', ':quitall<CR>', default_opts)

-----------------------------------------------------------
-- Plugins shortcuts:
-----------------------------------------------------------
-- nvim-tree
map('n', '<C-g>', ':NvimTreeToggle<CR>', default_opts)       -- open/close
map('n', '<S-r>', ':NvimTreeRefresh<CR>', default_opts)  -- refresh
map('n', '<C-f>', ':NvimTreeFindFile<CR>', default_opts) -- search file

-- Vista
-- map('', '<C-m>', ':Vista<CR>', default_opts)  -- open/close vista window

-- Telescope
-- map('n', '<C-p>', ':Telescope find_files hidden=true<CR>', default_opts) -- search file
map('n', '<C-p>', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<CR>", default_opts) -- search file
map('n', '<leader>fw', ':Telescope live_grep hidden=true<CR>', default_opts) -- search string
map('n', '<leader>fh', '::Telescope oldfiles<CR>', default_opts) -- search file
map('n', '<leader>fb', "<cmd>lua require'telescope.builtin'.buffers{}<CR>", default_opts) -- search file
map('n', '<leader>fm', "<cmd>lua require'telescope.builtin'.marks{}<CR>", default_opts) -- search file
-- Pending Telescope Buffer commands
