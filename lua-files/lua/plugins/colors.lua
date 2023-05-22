return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'mocha',
      integrations = {
        gitsigns = true,
        noice = true,
        notify = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        indent_blankline = {
          enabled = true,
          -- To enable to following, check the documentation:
          -- https://github.com/catppuccin/nvim#special-integrations
          colored_indent_levels = false,
        },
      },
      dim_inactive = {
        enabled = true,
        percentage = 0.40,
        shade = 'light',
      }
    },
    config = function ()
      require('catppuccin').setup()
      vim.cmd.colorscheme('catppuccin')
    end,
  },

  -----------------------------------------------------------
  -- Treesitter configuration file
  --- https://github.com/nvim-treesitter/nvim-treesitter
  -----------------------------------------------------------
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      autopairs = {
        enable = true
      },
      highlight = {
        enable = true,
      },
      ensure_installed =  {
        'javascript',
        'html',
        'css',
        'scss',
        'json',
        'glimmer',
        'jsdoc',
        'lua',
        'ruby',
        'tsx',
        'typescript',
        'vim',
        'regex',
        'bash',
        'markdown',
        'markdown_inline'
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      indent = {
        enable = true
      }
    },
    build = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require('nvim-treesitter.configs').setup({})
    end
  }
}
