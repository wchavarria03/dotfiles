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

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

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

  -- CUSTOM MAPPINGS
  vim.keymap.set('n', '<leader>tr', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<leader>tR', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', '<leader>tX', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', '<leader>tx', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '<leader>te', api.tree.expand_all, opts('Expand All'))
  vim.keymap.set('n', '<leader>tE', api.tree.collapse_all, opts('Collapse All'))
  vim.keymap.set('n', '<leader>tp', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', '<leader>tP', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', '<leader>to', ':lua OpenNodeInFinder()<CR>', opts('Open Finder'))
end


require'nvim-tree'.setup {
  on_attach = on_attach,
  renderer = {
    indent_markers = {
      enable = true,
    }
  },
  filters  = {
    custom = {'.git', 'node_modules', '.cache'}
  }
}

-- Keybindings are defined in `keymapping.lua`
--- See: `help NvimTree`
--- https://github.cm/kyazdani42/nvim-tree.lua#keybindingso
