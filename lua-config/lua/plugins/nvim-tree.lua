local utils = require('config.utils')
local merge_tb = vim.tbl_deep_extend

local function on_attach(bufnr)
	local api = require('nvim-tree.api')

	api.config.mappings.default_on_attach(bufnr)

	local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }

	-- CUSTOM MAPPINGS
	opts.desc = 'CD'
	utils.mapKey('TREE', 'n', '<leader>tr', api.tree.change_root_to_node, opts)

	opts.desc = 'Up'
	utils.mapKey('TREE', 'n', '<leader>tR', api.tree.change_root_to_parent, opts)

	opts.desc = 'Parent Directory'
	utils.mapKey('TREE', 'n', '<leader>tX', api.node.navigate.parent, opts)

	opts.desc = 'Close Directory'
	utils.mapKey('TREE', 'n', '<leader>tx', api.node.navigate.parent_close, opts)

	opts.desc = 'Expand All'
	utils.mapKey('TREE', 'n', '<leader>te', api.tree.expand_all, opts)

	opts.desc = 'Collapse All'
	utils.mapKey('TREE', 'n', '<leader>tE', api.tree.collapse_all, opts)

	opts.desc = 'Copy Relative Path'
	utils.mapKey('TREE', 'n', '<leader>tp', api.fs.copy.relative_path, opts)

	opts.desc = 'Copy Absolute Path'
	utils.mapKey('TREE', 'n', '<leader>tP', api.fs.copy.absolute_path, opts)
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
			{
				'<leader>tf',
				':NvimTreeFindFile<CR>',
				{ noremap = true, silent = true, desc = 'TREE: Focus tree' },
			},
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
				},
			},
			filters = {
				git_ignored = false,
				custom = { '.git', 'node_modules', '.cache' },
				exclude = { '.github' },
			},
			view = {
				side = 'right',

				width = 40,
			},
		},
		config = function(_, opts)
			local g = vim.g

			g.nvim_tree_git_hl = 1
			g.nvim_tree_width_allow_resize = 1
			g.nvim_tree_group_empty = 1
			g.nvim_tree_show_icons = {
				git = 1,
				folders = 1,
				files = 1,
			}

			g.nvim_tree_icons = {
				default = '‣ ',
			}

			require('nvim-tree').setup(merge_tb('force', opts, {
				on_attach = on_attach,
			}))
		end,
	},
}
