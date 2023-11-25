-----------------------------------------------------------
 -- Statusline configuration file ---------------------------------------------------------

--[[
  Plugin: lualine.nvim
  https://github.com/nvim-lualine/lualine.nvim
--]]

local utils = require "core.utils"
local merge_tb = vim.tbl_deep_extend

local comps = {
  file_name = {
    'filename',
    file_status = true,      -- Displays file status (readonly status, modified status)
    newfile_status = false,  -- Display new file status (new file means no write after created)
    path = 1,                -- 0: Just the filename
                             -- 1: Relative path
                             -- 2: Absolute path
                             -- 3: Absolute path, with tilde as the home directory
                             -- 4: Filename and parent dir, with tilde as the home directory

    shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                             -- for other components. (terrible name, any suggestions?)
    symbols = {
      modified = ' ',      -- Text to show when the buffer is modified
      readonly = ' 🔒',      -- Text to show when the file is non-modifiable or readonly.
      unnamed = '[No Name]', -- Text to show for unnamed buffers.
      newfile = '[New]',     -- Text to show for newly created file before first write
      directory =  '',     -- Text to show when the buffer is a directory
      alternate_file = '#', -- Text to show to identify the alternate file
    }
  },
  diff = {
    'diff',
    colored = true, -- Displays a colored diff status if set to true
    diff_color = {
      -- Same color values as the general color option can be used here.
      added    = 'DiffAdd',    -- Changes the diff's added color
      modified = 'DiffChange', -- Changes the diff's modified color
      removed  = 'DiffDelete', -- Changes the diff's removed color you
    },
    symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the symbols used by the diff.
    source = nil, -- A function that works as a data source for diff.
                  -- It must return a table as such:
                  --   { added = add_count, modified = modified_count, removed = removed_count }
                  -- or nil on failure. count <= 0 won't be displayed.
  },
  diagnostics = {
    'diagnostics',

    -- Table of diagnostic sources, available sources are:
    --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
    -- or a function that returns a table as such:
    --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
    sources = { 'nvim_lsp' },

    -- Displays diagnostics for the defined severity types
    sections = { 'error', 'warn', 'info', 'hint' },

    diagnostics_color = {
      -- Same values as the general color option can be used here.
      error = 'DiagnosticError', -- Changes diagnostics' error color.
      warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
      info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
      hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
    },
    symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
    colored = true,           -- Displays diagnostics status in color if set to true.
    update_in_insert = false, -- Update diagnostics in insert mode.
    always_visible = false,   -- Show diagnostics even if there are none.
  }
}

return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy' ,
    init = function()
      -- disable until lualine loads
      vim.opt.laststatus = 0
    end,
    opts = {
      theme = 'catppuccin',
      disabled_filetypes = {
        'NvimTree' ,
        statusline = {},
        winbar = {},
      },
      sections = {
        lualine_a = {},
        lualine_b = {
          'mode',
          comps.diff,
          comps.diagnostics
        },
        lualine_c = {
          comps.file_name
        },
        lualine_x = {
          'encoding',
          'filetype'
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          comps.file_name
        },
        lualine_y = {},
        lualine_x = {'progress'},
        lualine_z = {'location'}
      },
      extensions = { 'nvim-tree' },
      filetypes = { 'NvimTree' },
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    version = '*',
    opts = function ()
      local bufferline = require('bufferline')
      return {
        style_preset = bufferline.style_preset.no_italic,
        numbers = 'ordinal',
        show_buffer_close_icons = false,
        diagnostics = "nvim_lsp",
        separator_style = "thin",
        indicator = {
          icon = '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'icon',
        },
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true
          }
        },
        hover = {
          enabled = false,
        }
      }
    end,
    config = function (_, opts)
      local bufferline = require('bufferline')
      local buffer_opts = { silent = true }
      bufferline.setup {
        options = opts
      }

      utils.mapKey('Buffer', 'n', '<leader>bd', ':bd<CR>', merge_tb('force', buffer_opts, { desc = 'Buffer Delete'}))
      utils.mapKey('Buffer', 'n', '<leader>bn', ':BufferLineCycleNext<CR>',  merge_tb('force', buffer_opts, { desc = 'Next'}))
      utils.mapKey('Buffer', 'n', '<leader>bc', ':%bdelete|edit#|bdelete#', merge_tb('force', buffer_opts, { desc = 'Close all but'}))



      utils.mapKey('Buffer', 'n', '<leader>b1', '<Cmd>BufferLineGoToBuffer 1<CR>', merge_tb('force', buffer_opts, { desc = 'Go 1'}))
      utils.mapKey('Buffer', 'n', '<leader>b2', '<Cmd>BufferLineGoToBuffer 2<CR>', merge_tb('force', buffer_opts, { desc = 'Go 2'}))
      utils.mapKey('Buffer', 'n', '<leader>b3', '<Cmd>BufferLineGoToBuffer 3<CR>', merge_tb('force', buffer_opts, { desc = 'Go 3'}))
      utils.mapKey('Buffer', 'n', '<leader>b4', '<Cmd>BufferLineGoToBuffer 4<CR>', merge_tb('force', buffer_opts, { desc = 'Go 4'}))
      utils.mapKey('Buffer', 'n', '<leader>b5', '<Cmd>BufferLineGoToBuffer 5<CR>', merge_tb('force', buffer_opts, { desc = 'Go 5'}))
      utils.mapKey('Buffer', 'n', '<leader>b6', '<Cmd>BufferLineGoToBuffer 6<CR>', merge_tb('force', buffer_opts, { desc = 'Go 6'}))
      utils.mapKey('Buffer', 'n', '<leader>b7', '<Cmd>BufferLineGoToBuffer 7<CR>', merge_tb('force', buffer_opts, { desc = 'Go 7'}))
      utils.mapKey('Buffer', 'n', '<leader>b8', '<Cmd>BufferLineGoToBuffer 8<CR>', merge_tb('force', buffer_opts, { desc = 'Go 8'}))
      utils.mapKey('Buffer', 'n', '<leader>b9', '<Cmd>BufferLineGoToBuffer 9<CR>', merge_tb('force', buffer_opts, { desc = 'Go 9'}))
    end,
    dependencies = 'nvim-tree/nvim-web-devicons',
  }
}
