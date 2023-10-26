-----------------------------------------------------------
-- Nvim Telescope configuration file
-----------------------------------------------------------

-- Plugin: nvim-telescope
--- https://github.com/nvim-telescope/telescope.nvim

local utils = require "core.utils"

return {
  {
    'junegunn/fzf.vim',
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    event = 'VeryLazy',
    cmd = 'Telescope',
    keys = {
      { '<C-p>', ':Telescope find_files<CR>', { noremap = true, silent = true, desc = 'Telescope Find Files' } },
      { '<leader>fw', ':NvimTreeFindFile<CR>', { noremap = true, silent = true, desc = 'TelescopeFind Words' } },
    },
    config = function()
      local telescope = require('telescope');
      local actions = require('telescope.actions');
      local builtin = require('telescope.builtin')

      telescope.setup({
        defaults = {
          mappings = {
            -- TODO Add desc to the following keys to improve which-key suggestions
            i = {
              ['<esc>'] = actions.close,
              ['<C-k>'] = 'move_selection_previous',
              ['<C-j>'] = 'move_selection_next',
              ['<C-h>'] = 'preview_scrolling_up',
              ['<C-l>'] = 'preview_scrolling_down',
              ['<C-w>'] = 'which_key',
            }
          }
        }
      })

      utils.mapKey('Telescope', 'n', '<C-p>', builtin.find_files, { desc = 'Find Files' })
      utils.mapKey('Telescope', 'n', '<leader>fw', builtin.live_grep, { desc = 'Grep Text' })
      utils.mapKey('Telescope', 'n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
      utils.mapKey('Telescope', 'n', '<leader>fm', builtin.marks, { desc = 'Marks' })
      utils.mapKey('Telescope', 'n', '<leader>fh', builtin.help_tags, { desc = 'Help Tags' })
      utils.mapKey('Telescope', 'n', '<leader>fc', builtin.git_commits, { desc = 'Git Commits' })
      utils.mapKey('Telescope', 'n', '<leader>fs', builtin.git_status, { desc = 'Git Status' })
    end,
    dependencies = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    cmd = 'Telescope',
    build = 'make',
    config = function()
      -- TODO Test performance using fzf
      require('telescope').load_extension('fzf')
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
    },
  }
}
