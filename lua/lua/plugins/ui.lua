local utils = require 'core.utils'
local merge_tb = vim.tbl_deep_extend

return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    ft = 'gitcommit',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
      preview_config = {
        border = 'rounded',
      },
      on_attach = function(buffer)
        local gs = require 'gitsigns'
        local opts = { buffer = buffer }

        utils.mapKey('[G]itsigns', 'n', ']c', gs.next_hunk, merge_tb('force', opts, { desc = 'Next Hunk' }))
        utils.mapKey('[G]itsigns', 'n', '[c', gs.prev_hunk, merge_tb('force', opts, { desc = 'Prev Hunk' }))
        utils.mapKey('[G]itsigns', 'n', '<leader>gs', gs.stage_hunk, merge_tb('force', opts, { desc = '[S]tage Hunk' }))
        utils.mapKey('[G]itsigns', 'n', '<leader>gr', gs.reset_hunk, merge_tb('force', opts, { desc = '[R]eset Hunk' }))
        utils.mapKey('[G]itsigns', 'v', '<leader>gs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, merge_tb('force', opts, { desc = '[S]tage Hunk' }))
        utils.mapKey('[G]itsigns', 'v', '<leader>gr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, merge_tb('force', opts, { desc = '[R]eset Hunk' }))
        utils.mapKey('[G]itsigns', 'n', '<leader>gu', gs.undo_stage_hunk, merge_tb('force', opts, { desc = '[U]ndo Stage Hunk' }))
        utils.mapKey('[G]itsigns', 'n', '<leader>gS', gs.stage_buffer, merge_tb('force', opts, { desc = '[S]tage Buffer' }))
        utils.mapKey('[G]itsigns', 'n', '<leader>gR', gs.reset_buffer, merge_tb('force', opts, { desc = '[R]eset Buffer' }))
        utils.mapKey('[G]itsigns', 'n', '<leader>gp', gs.preview_hunk, merge_tb('force', opts, { desc = '[P]review Hunk' }))
        utils.mapKey('[G]itsigns', 'n', '<leader>gb', function()
          gs.blame_line { full = true }
        end, merge_tb('force', opts, { desc = '[B]lame Line' }))
        utils.mapKey('[G]itsigns', 'n', '<leader>gtb', gs.toggle_current_line_blame, merge_tb('force', opts, { desc = '[T]oggle [B]lame Line' }))
        utils.mapKey('[G]itsigns', 'n', '<leader>gd', gs.diffthis, merge_tb('force', opts, { desc = '[D]iff This' }))
        utils.mapKey('[G]itsigns', 'n', '<leader>gD', function()
          gs.diffthis '~'
        end, merge_tb('force', opts, { desc = '[D]iff This ~' }))
        utils.mapKey('[G]itsigns', 'n', '<leader>gtd', gs.toggle_deleted, merge_tb('force', opts, { desc = '[T]oggle [D]eleted' }))
        utils.mapKey('[G]itsigns', { 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', merge_tb('force', opts, { desc = 'Select Hunk' }))
      end,
    },
  },
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>nd',
        function()
          require('notify').dismiss { silent = true, pending = true }
        end,
        desc = 'Dismiss all Notifications',
      },
    },
    config = function()
      require('notify').setup {
        fps = 120,
        render = 'minimal',
        timeout = 500,
        top_down = true,
      }
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      window = {
        border = 'single',
      },
    },
    config = function(_, opts)
      require('which-key').setup(opts)
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
    end,
  },
  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },
}
