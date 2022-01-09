-----------------------------------------------------------
-- Nvim Telescope configuration file
-----------------------------------------------------------

-- Plugin: nvim-telescope
--- https://github.com/nvim-telescope/telescope.nvim

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden'
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-k>"] = "move_selection_previous",
        ["<C-j>"] = "move_selection_next",
        ["<C-h>"] = "preview_scrolling_up",
        ["<C-l>"] = "preview_scrolling_down",
      }
    }
  }
}

