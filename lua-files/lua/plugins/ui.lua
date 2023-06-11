local utils = require "core.utils"
local merge_tb = vim.tbl_deep_extend

return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    ft = 'gitcommit',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    opts = {
      signcolumn = true,          -- Toggle with `:Gitsigns toggle_signs`
      numhl      = true,          -- Toggle with `:Gitsigns toggle_numhl`
      word_diff  = false,         -- Toggle with `:Gitsigns toggle_word_diff`
      preview_config = {
        -- Options passed to nvim_open_win
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local opts = { buffer = buffer }

        utils.mapKey('Gitsigns', 'n', '<leader>gn', gs.next_hunk, merge_tb('force', opts, { desc = 'Next Hunk' }))
        utils.mapKey('Gitsigns', 'n', '<leader>gp', gs.prev_hunk, merge_tb('force', opts, { desc = 'Prev Hunk' }))
        utils.mapKey('Gitsigns', { 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', merge_tb('force', opts, { desc = 'Stage Hunk'}))
        utils.mapKey('Gitsigns', { 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', merge_tb('force', opts, { desc = 'Reset Hunk'}))
        utils.mapKey('Gitsigns', 'n', '<leader>gS', gs.stage_buffer, merge_tb('force', opts, { desc = 'Stage Buffer'}))
        utils.mapKey('Gitsigns', 'n', '<leader>gu', gs.undo_stage_hunk, merge_tb('force', opts, { desc = 'Undo Stage Hunk'}))
        utils.mapKey('Gitsigns', 'n', '<leader>gR', gs.reset_buffer, merge_tb('force', opts, { desc = 'Reset Buffer'}))
        utils.mapKey('Gitsigns', 'n', '<leader>gp', gs.preview_hunk, merge_tb('force', opts, { desc = 'Preview Hunk'}))
        utils.mapKey('Gitsigns', 'n', '<leader>gb', function() gs.blame_line({ full = true }) end, merge_tb('force', opts, { desc = 'Blame Line'}))
        utils.mapKey('Gitsigns', 'n', '<leader>gd', gs.diffthis, merge_tb('force', opts, { desc = 'Diff This'}))
        utils.mapKey('Gitsigns', 'n', '<leader>gD', function() gs.diffthis('~') end, merge_tb('force', opts, { desc = 'Diff This ~'}))
        utils.mapKey('Gitsigns', { 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', merge_tb('force', opts, { desc = 'Select Hunk'}))
      end,
    }
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      char_list = { '│', '¦', '┆', '┊' },
      filetype_exclude = {
        'TelescopePrompt',
        'TelescopeResults',
        'alpha',
        'help',
        'lazy',
        'lspinfo',
        'mason',
        'nvim-tree',
        'terminal',
      },
      buftype_exclude = { 'terminal', 'nofile' },
      show_current_context = true,
      show_current_context_start = true,
      show_end_of_line = false,
      show_first_indent_level = false,
      show_trailing_blankline_indent = false,
      space_char_blankline = ' ',
    }
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    config = function()
      require('noice').setup({
        presets = {
          long_message_to_split = true, -- long messages will be sent to a split
          command_palette = true, -- position the cmdline and popupmenu together
          inc_rename = true, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true,
        },
        routes = {
          {
            view = 'mini',
            filter = {
              any = {
                { event = 'msg_showmode' }, -- see :h showmode
                { find = ' change' }, -- to use string.find() on message
                { event = 'msg_history_show' }, -- for :messages output
                { event = 'msg_show', kind = 'wmsg' }, -- see :h W10
                { find = 'E486' }, -- see :h E486
                { event = 'msg_showcmd' }, -- see :h showcmd
                { event = 'msg_show', kind = 'quickfix' },
                { event = 'msg_show', kind = 'search_count' },
                { event = 'msg_show', find = '%d+L, %d+B' },
                { event = 'msg_show', find = 'Hunk %d+ of %d+' }
              },
            },
          },
          {
            filter = {
              any = {
                { event = 'msg_show', find = '%d+ more lines' },
                { event = 'msg_show', find = '%d+ lines yanked' },
                { event = 'msg_show', kind = '', find = 'written' },
                -- { event = 'msg_show', kind = 'search_count' },
              },
            },
            opts = { skip = true },
          }
        },
      })

      require('telescope').load_extension('noice')
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>un',
        function()
          require('notify').dismiss({ silent = true, pending = true })
        end,
        desc = 'Dismiss all Notifications',
      },
    },
    config = function()
      require('notify').setup({
        top_down = true
      });
    end
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      window = {
        border = 'single'
      }
    },
    config = function(_, opts)
      require('which-key').setup(opts)
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end
  },
  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    tag = 'legacy',
    opts = {
      window = {
        blend = 0,
      }
    },
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinNew" },
  }
}
