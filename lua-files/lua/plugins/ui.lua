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
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local bufmap = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = 'GitSigns: ' .. desc })
        end

        -- stylua: ignore start
        bufmap('n', '<leader>gn', gs.next_hunk, 'Next Hunk')
        bufmap('n', '<leader>gp', gs.prev_hunk, 'Prev Hunk')
        bufmap({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
        bufmap({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
        bufmap('n', '<leader>gS', gs.stage_buffer, 'Stage Buffer')
        bufmap('n', '<leader>gu', gs.undo_stage_hunk, 'Undo Stage Hunk')
        bufmap('n', '<leader>gR', gs.reset_buffer, 'Reset Buffer')
        bufmap('n', '<leader>gp', gs.preview_hunk, 'Preview Hunk')
        bufmap('n', '<leader>gb', function() gs.blame_line({ full = true }) end, 'Blame Line')
        bufmap('n', '<leader>gd', gs.diffthis, 'Diff This')
        bufmap('n', '<leader>gD', function() gs.diffthis('~') end, 'Diff This ~')
        bufmap({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Select Hunk')
      end,
    }
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      char_list = { '│', '¦', '┆', '┊' },
      filetype_exclude = { 'help', 'alpha', 'dashboard', 'nvim-tree', 'lazy', 'mason' },
      show_trailing_blankline_indent = false,
      show_current_context = false,
      show_end_of_line = false,
      space_char_blankline = ' ',
    }
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("noice").setup({
        presets = {
          long_message_to_split = true, -- long messages will be sent to a split
          command_palette = true, -- position the cmdline and popupmenu together
          inc_rename = true, -- enables an input dialog for inc-rename.nvim
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "written",
            },
            opts = { skip = true },
          },
          {
            filter = {
              event = "msg_show",
              kind = "search_count"
            },
            opts = { skip = true },
          },
          {
            view = "mini",
            filter = {
              any = {
                { event = "msg_showmode" }, -- see :h showmode
                { find = " change" }, -- to use string.find() on message
                { event = "msg_history_show" }, -- for :messages output
                { event = "msg_show", kind = "wmsg" }, -- see :h W10
                { find = "E486" }, -- see :h E486
                { event = "msg_showcmd" }, -- see :h showcmd
              },
            },
          },
        },
      })

      require("telescope").load_extension("noice")
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({
        top_down = true
      });
    end
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup({})
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end
  },
  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    opts = {
      window = {
        blend = 0,
      }
    },
  }
}
