local utils = require "core.utils"
local merge_tb = vim.tbl_deep_extend

return {
  {
    'nvim-neorg/neorg',
    event = 'VeryLazy',
    build = ':Neorg sync-parsers',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function ()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {},
          ['core.concealer'] = {},
          ['core.keybinds'] = {},
          ['core.dirman'] = {
            config = {
              workspaces = {
                work = '~/notes/work',
              },
              default_workspace = 'work'
            }
          },
          ['core.journal'] = {
            config = {
              journal_folder = 'daily_journal',
              strategy = 'flat',
            }
          },
        }
      }

      local opts = { noremap = true, silent = true }

      utils.mapKey('Neorg', 'n', '<leader>n', ':Neorg index<CR>', merge_tb('force', opts, { desc = 'Neorg index' }));
      utils.mapKey('Neorg', 'n', '<leader>nm', ':Neorg<CR>', merge_tb('force', opts, { desc = 'Neorg Menu' }));
      utils.mapKey('Neorg', 'n', '<leader>nc', ':Neorg return<CR>', merge_tb('force', opts, { desc = 'Neorg Close' }));

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  }
}
