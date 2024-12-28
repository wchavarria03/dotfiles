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
					path = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes',
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
			note_frontmatter_func = function(note)
				-- Add the title of the note as an alias.
				if note.title then
					note:add_alias(note.title)
				end

				local out = { id = note.id, aliases = note.aliases, tags = note.tags }

				-- `note.metadata` contains any manually added fields in the frontmatter.
				-- So here we just make sure those fields are kept in the frontmatter.
				if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
					for k, v in pairs(note.metadata) do
						out[k] = v
					end
				end

				return out
			end,
			-- Optional, customize how note file names are generated given the ID, target directory, and title.
			note_path_func = function(spec)
				-- Print the value of spec.title
				print('spec.title: ' .. tostring(spec.title))
				local path = spec.dir / tostring(spec.title)
				return path:with_suffix('.md')
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
