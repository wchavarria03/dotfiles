local utils = require('config.utils')
local merge_tb = vim.tbl_deep_extend

return {
	{
		'epwalsh/obsidian.nvim',
		version = '*', -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = 'markdown',
		event = { 'BufEnter' },
		opts = {
			workspaces = {
				{
					name = 'Notes',
					path = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents',
				},
			},
			templates = {
				subdir = 'templates',
				date_format = '%Y-%m-%d-%a',
				time_format = '%H:%M',
				substitutions = {},
			},
			daily_notes = {
				-- Optional, if you keep daily notes in a separate directory.
				folder = 'journal',
				-- Optional, if you want to change the date format for the ID of daily notes.
				date_format = '%Y-%m-%d',
				-- Optional, if you want to change the date format of the default alias of daily notes.
				alias_format = '%B %-d, %Y',
				-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
				template = 'daily.md',
			},
			preferred_link_style = 'markdown',
			open_notes_in = 'vsplit',
			follow_url_func = function(url)
				vim.fn.jobstart({ 'open', url }) -- Mac OS
			end,
		},
		config = function(_, opts)
			require('obsidian').setup(opts)

			local localOpts = { noremap = true, silent = true, nowait = true }
			utils.mapKey(
				'Notes:',
				'n',
				'<leader>fn',
				'<cmd>ObsidianQuickSwitch<CR>',
				merge_tb('force', localOpts, { desc = 'Find Notes' })
			)

			vim.keymap.set('n', 'gd', function()
				if require('obsidian').util.cursor_on_markdown_link() then
					return '<cmd>ObsidianFollowLink<CR>'
				else
					return 'gd'
				end
			end, { noremap = false, expr = true, desc = 'Notes: Follow Link' })
		end,
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
	},
}
