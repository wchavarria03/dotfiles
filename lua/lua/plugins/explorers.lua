-----------------------------------------------------------
-- File manager configuration file
-----------------------------------------------------------

-- Plugin: nvim-tree
-- https://github.com/kyazdani42/nvim-tree.lua

-- G config needs to be set  before setup call
local g = vim.g
local utils = require "core.utils"
local merge_tb = vim.tbl_deep_extend

g.nvim_tree_git_hl = 1
g.nvim_tree_width_allow_resize  = 1
g.nvim_tree_group_empty = 1
g.nvim_tree_special_files = {'README.md', 'Makefile', 'MAKEFILE'}
g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1
}

g.nvim_tree_icons = {
  default = '‣ '
}

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  -- Open tree node in the Finder
  _G.OpenNodeInFinder = function()
    local node = api.tree.get_node_under_cursor()
    local selected_file = node.absolute_path


    if not node.absolute_path then
      selected_file = vim.fn.expand('%')
    end

    local command = string.format('silent !open -R "%s"', selected_file)
    print (command)
    vim.cmd(command)
  end

  -- ADD ALL DEFAULT MAPPINGS ON_ATTACH
  api.config.mappings.default_on_attach(bufnr)

  local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }

  -- CUSTOM MAPPINGS
  utils.mapKey('NVIM-TREE', 'n', '<leader>tr', api.tree.change_root_to_node, merge_tb('force', opts, { desc = 'CD' }))
  utils.mapKey('NVIM-TREE', 'n', '<leader>tR', api.tree.change_root_to_parent, merge_tb('force', opts, { desc = 'Up' }))
  utils.mapKey('NVIM-TREE', 'n', '<leader>tX', api.node.navigate.parent, merge_tb('force', opts, { desc = 'Parent Directory' }))
  utils.mapKey('NVIM-TREE', 'n', '<leader>tx', api.node.navigate.parent_close, merge_tb('force', opts, { desc = 'Close Directory' }))
  utils.mapKey('NVIM-TREE', 'n', '<leader>te', api.tree.expand_all, merge_tb('force', opts, { desc = 'Expand All' }))
  utils.mapKey('NVIM-TREE', 'n', '<leader>tE', api.tree.collapse_all, merge_tb('force', opts, { desc = 'Collapse All' }))
  utils.mapKey('NVIM-TREE', 'n', '<leader>tp', api.fs.copy.relative_path, merge_tb('force', opts, { desc = 'Copy Relative Path' }))
  utils.mapKey('NVIM-TREE', 'n', '<leader>tP', api.fs.copy.absolute_path, merge_tb('force', opts, { desc = 'Copy Absolute Path' }))
  utils.mapKey('NVIM-TREE', 'n', '<leader>to', ':lua OpenNodeInFinder()<CR>', merge_tb('force', opts, { desc = 'Open Finder' }))
end

return {
  {
    'kyazdani42/nvim-tree.lua',
    cmd = {
      'NvimTreeFindFile',
      'NvimTreeRefresh',
      'NvimTreeToggle',
      'NvimTreeOpen',
      'NvimTreeFocus',
      'NvimTreeFindFileToggle',
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>tt', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = 'NVIM-TREE: Toggle tree' } },
      { '<leader>tf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true, desc = 'NVIM-TREE: Focus tree' } },
    },
    opts = {
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      sync_root_with_cwd = true,
      renderer = {
        indent_markers = {
          enable = true,
        }
      },
      filters  = {
        custom = {'.git', 'node_modules', '.cache'},
        dotfiles = false
      }
    },
    config = function(_, opts)
      require('nvim-tree').setup(
        merge_tb('force', opts, {
          on_attach = on_attach,
        })
      )
    end
  }
}


