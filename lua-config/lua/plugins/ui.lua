local utils = require('config.utils')
local merge_tb = vim.tbl_deep_extend

return {
	{
		'lewis6991/gitsigns.nvim',
		event = { 'BufReadPost', 'BufNewFile' },
		ft = 'gitcommit',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			preview_config = {
				border = 'rounded',
			},
			on_attach = function(buffer)
				local gs = require('gitsigns')
				local opts = { buffer = buffer }

				utils.mapKey('[G]itsigns', 'n', ']c', gs.next_hunk, merge_tb('force', opts, { desc = 'Next Hunk' }))
				utils.mapKey('[G]itsigns', 'n', '[c', gs.prev_hunk, merge_tb('force', opts, { desc = 'Prev Hunk' }))
				utils.mapKey(
					'[G]itsigns',
					'n',
					'<leader>gs',
					gs.stage_hunk,
					merge_tb('force', opts, { desc = '[S]tage Hunk' })
				)
				utils.mapKey(
					'[G]itsigns',
					'n',
					'<leader>gr',
					gs.reset_hunk,
					merge_tb('force', opts, { desc = '[R]eset Hunk' })
				)
				utils.mapKey('[G]itsigns', 'v', '<leader>gs', function()
					gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
				end, merge_tb('force', opts, { desc = '[S]tage Hunk' }))
				utils.mapKey('[G]itsigns', 'v', '<leader>gr', function()
					gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
				end, merge_tb('force', opts, { desc = '[R]eset Hunk' }))
				utils.mapKey(
					'[G]itsigns',
					'n',
					'<leader>gu',
					gs.undo_stage_hunk,
					merge_tb('force', opts, { desc = '[U]ndo Stage Hunk' })
				)
				utils.mapKey(
					'[G]itsigns',
					'n',
					'<leader>gS',
					gs.stage_buffer,
					merge_tb('force', opts, { desc = '[S]tage Buffer' })
				)
				utils.mapKey(
					'[G]itsigns',
					'n',
					'<leader>gR',
					gs.reset_buffer,
					merge_tb('force', opts, { desc = '[R]eset Buffer' })
				)
				utils.mapKey(
					'[G]itsigns',
					'n',
					'<leader>gp',
					gs.preview_hunk,
					merge_tb('force', opts, { desc = '[P]review Hunk' })
				)
				utils.mapKey('[G]itsigns', 'n', '<leader>gb', function()
					gs.blame_line({ full = true })
				end, merge_tb('force', opts, { desc = '[B]lame Line' }))
				utils.mapKey(
					'[G]itsigns',
					'n',
					'<leader>gtb',
					gs.toggle_current_line_blame,
					merge_tb('force', opts, { desc = '[T]oggle [B]lame Line' })
				)
				utils.mapKey(
					'[G]itsigns',
					'n',
					'<leader>gd',
					gs.diffthis,
					merge_tb('force', opts, { desc = '[D]iff This' })
				)
				utils.mapKey('[G]itsigns', 'n', '<leader>gD', function()
					gs.diffthis('~')
				end, merge_tb('force', opts, { desc = '[D]iff This ~' }))
				utils.mapKey(
					'[G]itsigns',
					'n',
					'<leader>gtd',
					gs.toggle_deleted,
					merge_tb('force', opts, { desc = '[T]oggle [D]eleted' })
				)
				utils.mapKey(
					'[G]itsigns',
					{ 'o', 'x' },
					'ih',
					':<C-U>Gitsigns select_hunk<CR>',
					merge_tb('force', opts, { desc = 'Select Hunk' })
				)
			end,
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
				desc = 'Dismiss All Notifications',
			},
		},
		opts = {
			stages = 'static',
			timeout = 500,
			render = 'minimal',
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 100 })
			end,
		},
	},
	{
		'akinsho/bufferline.nvim',
		event = { 'BufReadPost', 'BufNewFile' },
		version = '*',
		opts = function()
			local bufferline = require('bufferline')
			return {
				style_preset = bufferline.style_preset.no_italic,
				numbers = 'ordinal',
				show_buffer_close_icons = false,
				diagnostics = 'nvim_lsp',
				indicator = {
					style = 'icon',
					icon = '|',
				},
				offsets = {
					{
						filetype = 'NvimTree',
						text = 'File Explorer',
						text_align = 'center',
						separator = true,
					},
				},
				hover = {
					enabled = false,
				},
			}
		end,
		config = function(_, opts)
			local bufferline = require('bufferline')
			local buffer_opts = { silent = true }
			bufferline.setup({
				options = opts,
				highlights = {
					buffer_selected = {
						bold = false,
						italic = false,
						fg = '#000000',
						bg = '#9cdf9b',
					},
					numbers_selected = {
						bold = false,
						italic = false,
						fg = '#000000',
						bg = '#9cdf9b',
					},
				},
			})

			utils.mapKey(
				'Buffer',
				'n',
				'<leader>bc',
				':bd<CR>',
				merge_tb('force', buffer_opts, { desc = 'Buffer Close' })
			)
			utils.mapKey(
				'Buffer',
				'n',
				'<leader>b',
				':BufferLineCycleNext<CR>',
				merge_tb('force', buffer_opts, { desc = 'Next' })
			)
			utils.mapKey(
				'Buffer',
				'n',
				'<leader>bp',
				':BufferLineCyclePrev<CR>',
				merge_tb('force', buffer_opts, { desc = 'Prev' })
			)
			utils.mapKey(
				'Buffer',
				'n',
				'<leader>bca',
				':BufferLineCloseOthers<CR>',
				merge_tb('force', buffer_opts, { desc = 'Close all but' })
			)
			utils.mapKey(
				'Buffer',
				'n',
				'<leader>bf',
				':BufferLinePick<CR>',
				merge_tb('force', buffer_opts, { desc = 'Pick Buffer' })
			)

			utils.mapKey(
				'Buffer',
				'n',
				'<leader>b1',
				'<Cmd>BufferLineGoToBuffer 1<CR>',
				merge_tb('force', buffer_opts, { desc = 'Go 1' })
			)
			utils.mapKey(
				'Buffer',
				'n',
				'<leader>b2',
				'<Cmd>BufferLineGoToBuffer 2<CR>',
				merge_tb('force', buffer_opts, { desc = 'Go 2' })
			)
			utils.mapKey(
				'Buffer',
				'n',
				'<leader>b3',
				'<Cmd>BufferLineGoToBuffer 3<CR>',
				merge_tb('force', buffer_opts, { desc = 'Go 3' })
			)
			utils.mapKey(
				'Buffer',
				'n',
				'<leader>b4',
				'<Cmd>BufferLineGoToBuffer 4<CR>',
				merge_tb('force', buffer_opts, { desc = 'Go 4' })
			)
			utils.mapKey(
				'Buffer',
				'n',
				'<leader>b5',
				'<Cmd>BufferLineGoToBuffer 5<CR>',
				merge_tb('force', buffer_opts, { desc = 'Go 5' })
			)
			utils.mapKey(
				'Buffer',
				'n',
				'<leader>b6',
				'<Cmd>BufferLineGoToBuffer 6<CR>',
				merge_tb('force', buffer_opts, { desc = 'Go 6' })
			)
			utils.mapKey(
				'Buffer',
				'n',
				'<leader>b7',
				'<Cmd>BufferLineGoToBuffer 7<CR>',
				merge_tb('force', buffer_opts, { desc = 'Go 7' })
			)
			utils.mapKey(
				'Buffer',
				'n',
				'<leader>b8',
				'<Cmd>BufferLineGoToBuffer 8<CR>',
				merge_tb('force', buffer_opts, { desc = 'Go 8' })
			)
			utils.mapKey(
				'Buffer',
				'n',
				'<leader>b9',
				'<Cmd>BufferLineGoToBuffer 9<CR>',
				merge_tb('force', buffer_opts, { desc = 'Go 9' })
			)
		end,
		dependencies = 'nvim-tree/nvim-web-devicons',
	},

	-- indent guides for Neovim
	{
		'lukas-reineke/indent-blankline.nvim',
		event = 'VeryLazy',
		opts = {
			indent = {
				char = '│',
				tab_char = '│',
			},
			scope = { show_start = false, show_end = false },
			exclude = {
				filetypes = {
					'help',
					'nvim-tree',
					'lazy',
					'mason',
					'notify',
				},
			},
		},
		main = 'ibl',
	},

	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		opts = {
			lsp = {
				override = {
					['vim.lsp.util.convert_input_to_markdown_lines'] = true,
					['vim.lsp.util.stylize_markdown'] = true,
					['cmp.entry.get_documentation'] = true,
				},
			},
			routes = {
				{
					filter = {
						event = 'msg_show',
						any = {
							{ find = '%d+L, %d+B' },
							{ find = '; after #%d+' },
							{ find = '; before #%d+' },
						},
					},
					view = 'mini',
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				lsp_doc_border = true,
			},
		},
		keys = {
			{ '<leader>sn', '', desc = '+noice' },
			{
				'<leader>snl',
				function()
					require('noice').cmd('last')
				end,
				desc = 'Noice Last Message',
			},
			{
				'<leader>snh',
				function()
					require('noice').cmd('history')
				end,
				desc = 'Noice History',
			},
			{
				'<leader>sna',
				function()
					require('noice').cmd('all')
				end,
				desc = 'Noice All',
			},
			{
				'<leader>snd',
				function()
					require('noice').cmd('dismiss')
				end,
				desc = 'Dismiss All',
			},
			{
				'<leader>snt',
				function()
					require('noice').cmd('pick')
				end,
				desc = 'Noice Picker (Telescope/FzfLua)',
			},
			{
				'<c-f>',
				function()
					if not require('noice.lsp').scroll(4) then
						return '<c-f>'
					end
				end,
				silent = true,
				expr = true,
				desc = 'Scroll Forward',
				mode = { 'i', 'n', 's' },
			},
			{
				'<c-b>',
				function()
					if not require('noice.lsp').scroll(-4) then
						return '<c-b>'
					end
				end,
				silent = true,
				expr = true,
				desc = 'Scroll Backward',
				mode = { 'i', 'n', 's' },
			},
		},
		config = function(_, opts)
			-- HACK: noice shows messages from before it was enabled,
			-- but this is not ideal when Lazy is installing plugins,
			-- so clear the messages in this case.
			if vim.o.filetype == 'lazy' then
				vim.cmd([[messages clear]])
			end
			require('noice').setup(opts)
		end,
	},

	-- icons
	{
		'echasnovski/mini.icons',
		lazy = true,
		init = function()
			package.preload['nvim-web-devicons'] = function()
				require('mini.icons').mock_nvim_web_devicons()
				return package.loaded['nvim-web-devicons']
			end
		end,
	},

	-- ui components
	{ 'MunifTanjim/nui.nvim', lazy = true },
	{
		'stevearc/dressing.nvim',
		opts = {},
	},
}
