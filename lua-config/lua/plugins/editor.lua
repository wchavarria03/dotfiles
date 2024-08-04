local utils = require('config.utils')
local merge_tb = vim.tbl_deep_extend

local function on_attach(bufnr)
	local api = require('nvim-tree.api')

	api.config.mappings.default_on_attach(bufnr)

	local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }

	-- CUSTOM MAPPINGS
	opts.desc = 'CD'
	utils.mapKey('NVIM-TREE', 'n', '<leader>tr', api.tree.change_root_to_node, opts)

	opts.desc = 'Up'
	utils.mapKey('NVIM-TREE', 'n', '<leader>tR', api.tree.change_root_to_parent, opts)

	opts.desc = 'Parent Directory'
	utils.mapKey('NVIM-TREE', 'n', '<leader>tX', api.node.navigate.parent, opts)

	opts.desc = 'Close Directory'
	utils.mapKey('NVIM-TREE', 'n', '<leader>tx', api.node.navigate.parent_close, opts)

	opts.desc = 'Expand All'
	utils.mapKey('NVIM-TREE', 'n', '<leader>te', api.tree.expand_all, opts)

	opts.desc = 'Collapse All'
	utils.mapKey('NVIM-TREE', 'n', '<leader>tE', api.tree.collapse_all, opts)

	opts.desc = 'Copy Relative Path'
	utils.mapKey('NVIM-TREE', 'n', '<leader>tp', api.fs.copy.relative_path, opts)

	opts.desc = 'Copy Absolute Path'
	utils.mapKey('NVIM-TREE', 'n', '<leader>tP', api.fs.copy.absolute_path, opts)
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
				{ noremap = true, silent = true, desc = 'NVIM-TREE: Focus tree' },
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
	{
		'folke/flash.nvim',
		event = 'VeryLazy',
		opts = {
			jump = {
				autojump = true,
			},
			modes = {
				search = { enabled = true },
				char = {
					enabled = false,
				},
			},
		},
		keys = {
			{
				'f',
				mode = { 'n', 'x', 'o' },
				function()
					require('flash').jump()
				end,
				desc = 'Flash',
			},
			{
				'S',
				mode = { 'n', 'o', 'x' },
				function()
					require('flash').treesitter()
				end,
				desc = 'Flash Treesitter',
			},
			{
				'r',
				mode = 'o',
				function()
					require('flash').remote()
				end,
				desc = 'Remote Flash',
			},
		},
	},
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		keys = {
			{
				'<leader>?',
				function()
					require('which-key').show({ global = false })
				end,
				desc = 'Buffer Keymaps (which-key)',
			},
			{
				'<c-w><space>',
				function()
					require('which-key').show({ keys = '<c-w>', loop = true })
				end,
				desc = 'Window Hydra Mode (which-key)',
			},
		},
		opts = {
			win = {
				border = 'single',
			},
			spec = {
				{
					mode = { 'n', 'v' },
					{ '<leader><tab>', group = 'tabs' },
					{
						'<leader>b',
						group = 'buffer',
						expand = function()
							return require('which-key.extras').expand.buf()
						end,
					},
					{ '<leader>c', group = 'code' },
					{ '<leader>f', group = 'file/find' },
					{ '<leader>g', group = 'git' },
					{ '<leader>gh', group = 'hunks' },
					{ '<leader>s', group = 'search' },
					{ '<leader>u', group = 'ui', icon = { icon = '󰙵 ', color = 'cyan' } },
					{
						'<leader>w',
						group = 'windows',
						proxy = '<c-w>',
						expand = function()
							return require('which-key.extras').expand.win()
						end,
					},
					{ '<leader>x', group = 'diagnostics/quickfix', icon = { icon = '󱖫 ', color = 'green' } },
					{ '[', group = 'prev' },
					{ ']', group = 'next' },
					{ 'g', group = 'goto' },
					{ 'gs', group = 'surround' },
				},
			},
		},
		config = function(_, opts)
			local wk = require('which-key')
			wk.setup(opts)
		end,
	},
	{
		'folke/todo-comments.nvim',
		cmd = { 'TodoTrouble', 'TodoTelescope' },
		event = 'VeryLazy',
		opts = {},
		keys = {
			{ '<leader>st', '<cmd>TodoTelescope<cr>', desc = '[S]earch [T]odo' },
			{ '<leader>sT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme' },
		},
	},
	{
		'j-hui/fidget.nvim',
		opts = {},
	},
	{
		'stevearc/oil.nvim',
		opts = {},
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('oil').setup({
				default_file_explorer = true,
				delete_to_trash = true,
				skip_confirmation_for_simple = true,
				view_options = {
					show_hidden = true,
					natural_order = true,
					is_always_hidden = function(name, _)
						return name == '..' or name == '.git'
					end,
				},
				win_options = {
					wrap = true,
				},
			})
		end,
	},
}
