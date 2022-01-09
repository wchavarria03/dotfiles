-----------------------------------------------------------
-- File manager configuration file
-----------------------------------------------------------

-- Plugin: nvim-tree
-- https://github.com/kyazdani42/nvim-tree.lua

-- G config needs to be set  before setup call
local g = vim.g
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'}
g.nvim_tree_gitignore = 1
-- g.nvim_tree_auto_open = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 0
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

-- default mappings
local list = {
  { key = "<CR>",                         cb = tree_cb("edit") },
  { key = "<C-a>",                       cb = tree_cb("cd") },
  { key = "<S-a>",                       cb = tree_cb("dir_up") },
  { key = "<C-v>",                        cb = tree_cb("vsplit") },
  { key = "<C-x>",                        cb = tree_cb("split") },
  { key = "X",                            cb = tree_cb("parent_node") },
  { key = "x" ,                           cb = tree_cb("close_node") },
  { key = "K",                            cb = tree_cb("first_sibling") },
  { key = "J",                            cb = tree_cb("last_sibling") },
  { key = "I",                            cb = tree_cb("toggle_ignored") },
  { key = "R",                            cb = tree_cb("refresh") },
  { key = "a",                            cb = tree_cb("create") },
  { key = "d",                            cb = tree_cb("remove") },
  { key = "r",                            cb = tree_cb("rename") },
  { key = "c",                            cb = tree_cb("copy") },
  { key = "p",                            cb = tree_cb("paste") },
  { key = "y",                            cb = tree_cb("copy_name") },
  { key = "Y",                            cb = tree_cb("copy_path") },
  { key = "gy",                           cb = tree_cb("copy_absolute_path") },
  { key = "s",                            cb = tree_cb("system_open") },
  { key = "g?",                           cb = tree_cb("toggle_help") }
}


require'nvim-tree'.setup {
  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,

    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = list
    }
  },
}

-- Keybindings are defined in `keymapping.lua`
--- See: `help NvimTree`
--- https://github.cm/kyazdani42/nvim-tree.lua#keybindingso
