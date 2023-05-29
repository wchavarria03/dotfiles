-----------------------------------------------------------
-- File manager configuration file
-----------------------------------------------------------

-- Plugin: nvim-tree
-- https://github.com/kyazdani42/nvim-tree.lua

-- G config needs to be set  before setup call
local g = vim.g

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
  default = "‣ "
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

  local bufmap = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, nowait = true, desc = 'NVIM-TREE: ' .. desc })
  end

  -- CUSTOM MAPPINGS
  bufmap('n', '<leader>tr', api.tree.change_root_to_node, 'CD')
  bufmap('n', '<leader>tR', api.tree.change_root_to_parent, 'Up')
  bufmap('n', '<leader>tX', api.node.navigate.parent, 'Parent Directory')
  bufmap('n', '<leader>tx', api.node.navigate.parent_close, 'Close Directory')
  bufmap('n', '<leader>te', api.tree.expand_all, 'Expand All')
  bufmap('n', '<leader>tE', api.tree.collapse_all, 'Collapse All')
  bufmap('n', '<leader>tp', api.fs.copy.relative_path, 'Copy Relative Path')
  bufmap('n', '<leader>tP', api.fs.copy.absolute_path, 'Copy Absolute Path')
  bufmap('n', '<leader>to', ':lua OpenNodeInFinder()<CR>', 'Open Finder')
end

return {
  {
    'kyazdani42/nvim-tree.lua',
    cmd = {
      'NvimTreeFindFile',
      'NvimTreeRefresh',
      'NvimTreeToggle',
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>tt', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = 'NVIM-TREE: Toggle tree' } },
      { '<leader>tf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true, desc = 'NVIM-TREE: Focus tree' } },
    },
    opts = {
      renderer = {
        indent_markers = {
          enable = true,
        }
      },
      filters  = {
        custom = {'.git', 'node_modules', '.cache'}
      }
    },
    config = function()
      require('nvim-tree').setup({
        on_attach = on_attach,
      })
    end
  }
}

