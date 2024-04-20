return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'mocha',
      integrations = {
        cmp = true,
        gitsigns = true,
        harpoon = true,
        mason = true,
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
        percentage = 0.60,
        shade = 'light',
      }
    },
    config = function (_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme('catppuccin')
      vim.api.nvim_command('highlight VertSplit guifg=#95bb92')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = {
      'TSInstall',
      'TSInstallInfo',
      'TSUpdate',
      'TSBufEnable',
      'TSBufDisable',
      'TSEnable',
      'TSDisable',
      'TSModuleInfo',
    },
    opts = {
      autopairs = {
        enable = true
      },
      highlight = {
        enable = true,
      },
      ensure_installed =  {
        'bash',
        'css',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'regex',
        'ruby',
        'scss',
        'tsx',
        'typescript',
        'vim',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<leader>ss',
          node_incremental = '<leader>si',
          node_decremental = '<leader>sd',
          scope_incremental = '<leader>ssi',
        },
      },
      indent = {
        enable = true
      }
    },
    build = ':TSUpdate',
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  }
}
