return {
 {
    'iamcco/markdown-preview.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    enabled = false,
    ft = {'markdown'},
    build = 'cd app && npm install',
    config = function()
        vim.g.mkdp_filetypes = { 'markdown' }
    end,
  },
  {
    'm4xshen/hardtime.nvim',
    event = 'VeryLazy',
    enabled = false,
    opts = {
      restricted_keys = {
        ['h'] = { 'n', 'v' },
        ['j'] = { 'n', 'v' },
        ['k'] = { 'n', 'v' },
        ['l'] = { 'n', 'v' },
        ['-'] = { 'n', 'v' },
        ['+'] = { 'n', 'v' }, ['gj'] = { 'n', 'v' },
        ['gk'] = { 'n', 'v' },
        ['<CR>'] = { 'n', 'v' },
        ['<C-M>'] = { 'n', 'v' },
        ['<C-N>'] = { 'n', 'v' },
      },
    }
  },
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
