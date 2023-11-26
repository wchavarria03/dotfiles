 -----------------------------------------------------------
 -- Statusline configuration file ---------------------------------------------------------
-----------------------------------------------------------

local utils = require "core.utils"
local merge_tb = vim.tbl_deep_extend

local function empty_component ()
   return '%='
end

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
        lualine_a = {
          {
            'mode',
          }
        },
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {
          {
            'filename',
            color = { fg = '#000000', bg = '#9cdf9b' }
          },
        },
        lualine_b = {
          {
            empty_component,
            color = { fg = '#000000', bg = '#9cdf9b' }
          }
        },
        lualine_c = {
          {
            empty_component,
            color = { fg = '#000000', bg = '#9cdf9b' }
          }
        },
        lualine_x = {
          {
            'location',
            color = { fg = '#000000', bg = '#9cdf9b' }
          },
        },
        lualine_y = {},
        lualine_z = {}
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
        indicator = {
          style = 'icon',
          icon = '|'
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
        },
      }
    end,
    config = function (_, opts)
      local bufferline = require('bufferline')
      local buffer_opts = { silent = true }
      bufferline.setup {
        options = opts,
        highlights = {
          buffer_selected = {
            bold = false,
            italic = false,
            fg = '#000000',
            bg = '#9cdf9b',
          },
          numbers_selected = {
            bold = false,
            italic = false,
            fg = '#000000',
            bg = '#9cdf9b',
          }
        },
      }

      utils.mapKey('Buffer', 'n', '<leader>bc', ':bd<CR>', merge_tb('force', buffer_opts, { desc = 'Buffer Close'}))
      utils.mapKey('Buffer', 'n', '<leader>b', ':BufferLineCycleNext<CR>',  merge_tb('force', buffer_opts, { desc = 'Next'}))
      utils.mapKey('Buffer', 'n', '<leader>bp', ':BufferLineCyclePrev<CR>',  merge_tb('force', buffer_opts, { desc = 'Prev'}))
      utils.mapKey('Buffer', 'n', '<leader>bca', ':BufferLineCloseOthers<CR>', merge_tb('force', buffer_opts, { desc = 'Close all but'}))
      utils.mapKey('Buffer', 'n', '<leader>bf', ':BufferLinePick<CR>', merge_tb('force', buffer_opts, { desc = 'Close all but'}))



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
