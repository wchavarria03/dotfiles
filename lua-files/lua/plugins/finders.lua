-----------------------------------------------------------
-- Nvim Telescope configuration file
-----------------------------------------------------------

-- Plugin: nvim-telescope
--- https://github.com/nvim-telescope/telescope.nvim
return {
  {
    "junegunn/fzf.vim",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    event = 'VeryLazy',
    cmd = "Telescope",
    keys = {
      { '<C-p>', ':Telescope find_files<CR>', { noremap = true, silent = true, desc = 'Find Files' } },
      { '<leader>fw', ':NvimTreeFindFile<CR>', { noremap = true, silent = true, desc = 'Find Words' } },
    },
    config = function()
      local telescope = require('telescope');
      local actions = require('telescope.actions');
      local builtin = require('telescope.builtin')

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-k>"] = "move_selection_previous",
              ["<C-j>"] = "move_selection_next",
              ["<C-h>"] = "preview_scrolling_up",
              ["<C-l>"] = "preview_scrolling_down",
              ["<C-w>"] = "which_key"
            },
            n = {
              ["<C-p>"] = builtin.find_files,
              ["<leader>fw"] = builtin.live_grep,
              ["<leader>fwh"] = builtin.live_grep,
              ["<leader>fb"] = builtin.buffers,
              ["<leader>fm"] = builtin.marks,
            },
          }
        }
      })
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fm', builtin.marks, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end,
    dependencies = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    cmd = "Telescope",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}