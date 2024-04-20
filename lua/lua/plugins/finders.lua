-----------------------------------------------------------
-- Nvim Telescope configuration file
-----------------------------------------------------------

-- Plugin: nvim-telescope
--- https://github.com/nvim-telescope/telescope.nvim

local utils = require "core.utils"

return {
  {
    'junegunn/fzf.vim',
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    event = 'VeryLazy',
    cmd = 'Telescope',
    keys = {
      { '<C-p>', ':Telescope find_files<CR>', { noremap = true, silent = true, desc = 'Telescope Find Files' } },
      { '<leader>fw', ':NvimTreeFindFile<CR>', { noremap = true, silent = true, desc = 'TelescopeFind Words' } },
    },
    config = function()
      local telescope = require('telescope');
      local actions = require('telescope.actions');
      local builtin = require('telescope.builtin')

      telescope.setup({
        defaults = {
          mappings = {
            -- TODO Add desc to the following keys to improve which-key suggestions
            i = {
              ['<esc>'] = actions.close,
              ['<C-k>'] = 'move_selection_previous',
              ['<C-j>'] = 'move_selection_next',
              ['<C-h>'] = 'preview_scrolling_up',
              ['<C-l>'] = 'preview_scrolling_down',
              ['<C-w>'] = 'which_key',
            }
          },
          file_ignore_patterns = {
            "node_modules",
            "yarn.lock",
            ".git",
            ".sl",
            "_build",
            ".next",
          },
          hidden = true,
        }
      })

      utils.mapKey('Telescope', 'n', '<C-p>', function()
        builtin.find_files({
          find_command = {
            'rg',
            '--files',
            '--hidden', -- Add this flag to include hidden files
            '--glob=!**/.git/*',
            '--glob=!**/build/*',
            '--glob=!**/dist/*',
            '--glob=!**/node_modules/*',
          },
        })
      end, { desc = 'Find Files' })

      utils.mapKey('Telescope', 'n', '<leader>fb', function()
        builtin.buffers({ show_all_buffers = true })
      end, { desc = 'Buffers' })

      -- utils.mapKey('Telescope', 'n', '<C-p>', builtin.find_files, { desc = 'Find Files' })j
      utils.mapKey('Telescope', 'n', '<leader>fw', builtin.live_grep, { desc = 'Grep Text' })
      utils.mapKey('Telescope', 'n', '<leader>fm', builtin.marks, { desc = 'Marks' })
      utils.mapKey('Telescope', 'n', '<leader>fh', builtin.help_tags, { desc = 'Help Tags' })
      utils.mapKey('Telescope', 'n', '<leader>fc', builtin.git_commits, { desc = 'Git Commits' })
      utils.mapKey('Telescope', 'n', '<leader>fs', builtin.git_status, { desc = 'Git Status' })
    end,
    dependencies = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    cmd = 'Telescope',
    build = 'make',
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      search = {
        multi_window = false,
        wrap = false,
        incremental = true,
      },
    },
    keys = {
      {
        "f",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
      local harpoon = require("harpoon")
      harpoon.setup()

      utils.mapKey('Harpoon', 'n', '<leader>ha', function() harpoon:list():append() end, { desc = 'Append to list' })

      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        }):find()
      end

      utils.mapKey('Harpoon', 'n', '<leader>hl', function() toggle_telescope(harpoon:list()) end, { desc = 'Open harpoon window' })
    end,
    dependencies = { "nvim-lua/plenary.nvim" }
  }
}
