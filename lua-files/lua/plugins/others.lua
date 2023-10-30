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
                personal = '~/notes/personal',
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

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  }
}
