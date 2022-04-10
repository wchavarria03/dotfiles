-----------------------------------------------------------
-- Treesitter configuration file
-----------------------------------------------------------

-- Plugin: nvim-treesitter
--- https://github.com/nvim-treesitter/nvim-treesitter
require('nvim-treesitter.configs').setup {
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
    'typescript'
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
}
