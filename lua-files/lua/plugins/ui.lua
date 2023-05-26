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

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map('n', ']h', gs.next_hunk, 'Next Hunk')
        map('n', '[h', gs.prev_hunk, 'Prev Hunk')
        map({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
        map({ 'n', 'v' }, '<leader>ghr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
        map('n', '<leader>ghS', gs.stage_buffer, 'Stage Buffer')
        map('n', '<leader>ghu', gs.undo_stage_hunk, 'Undo Stage Hunk')
        map('n', '<leader>ghR', gs.reset_buffer, 'Reset Buffer')
        map('n', '<leader>ghp', gs.preview_hunk, 'Preview Hunk')
        map('n', '<leader>ghb', function() gs.blame_line({ full = true }) end, 'Blame Line')
        map('n', '<leader>ghd', gs.diffthis, 'Diff This')
        map('n', '<leader>ghD', function() gs.diffthis('~') end, 'Diff This ~')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
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
