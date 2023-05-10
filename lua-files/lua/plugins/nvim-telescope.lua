-----------------------------------------------------------
-- Nvim Telescope configuration file
-----------------------------------------------------------

-- Plugin: nvim-telescope
--- https://github.com/nvim-telescope/telescope.nvim
local telescope = require('telescope');
local actions = require('telescope.actions');
local builtin = require('telescope.builtin')

telescope.setup{
  defaults = {
--     vimgrep_arguments = {
--       'rg',
--       '--color=never',
--       '--no-heading',
--       '--with-filename',
--       '--line-number',
--       '--column',
--       '--smart-case',
--       '--hidden'
--     },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-k>"] = "move_selection_previous",
        ["<C-j>"] = "move_selection_next",
        ["<C-h>"] = "preview_scrolling_up",
        ["<C-l>"] = "preview_scrolling_down",
      },
      n = {
        -- TODO: Looks like these are not working, pending to fix
        ["<C-p>"] = builtin.find_files,
        ["<leader>fw"] = builtin.live_grep,
        ["<leader>fwh"] = builtin.live_grep,
        ["<leader>fb"] = builtin.buffers,
        ["<leader>fm"] = builtin.marks,
      },
    }
  }
}

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

telescope.load_extension('fzf')
