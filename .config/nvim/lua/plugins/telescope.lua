local utils = require('config.utils')

return {
	{
		'junegunn/fzf.vim',
		event = { 'BufReadPost', 'BufNewFile' },
	},
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		event = 'VeryLazy',
		cmd = 'Telescope',
		config = function()
			local telescope = require('telescope')
			local actions = require('telescope.actions')
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
						},
					},
					file_ignore_patterns = {
						'node_modules',
						'yarn.lock',
						'.git',
						'.sl',
						'_build',
						'.next',
						'dist',
						'venv',
					},
					vimgrep_arguments = {
						'rg',
						'--hidden',
						'--color=never',
						'--no-heading',
						'--smart-case',
						'--with-filename',
						'--line-number',
						'--column',
					},
					extensions = {
						['ui-select'] = {
							require('telescope.themes').get_dropdown({
								winblend = 10,
								border = true,
								previewer = false,
							}),
						},
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require('telescope').load_extension, 'fzf')
			pcall(require('telescope').load_extension, 'ui-select')

			utils.mapKey('Telescope', 'n', '<C-p>', function()
				builtin.find_files({
					find_command = {
						'rg',
						'--files',
						'--glob=!**/.git/*',
						'--glob=!**/build/*',
						'--glob=!**/dist/*',
						'--glob=!**/node_modules/*',
						'--glob=!**/node_modules/*',
						'--glob=!**/venv/*',
						'--glob=!**/nvim/undodir/*',
						'--glob=!**/nvim/swap/*',
						'--glob=!**/nvim/backup/*',
						'--glob=!**/nvim/backupdir/*',
						'--glob=!**/asdf/plugins/*',
						'--glob=!**/asdf/installs/*',
						'--glob=!**/asdf/shims/*',
						'--glob=!**/local/share/*',
						'--glob=!**/.config/cache/*',
						'--glob=!**/.config/zsh/.zcompdump',
					},
					hidden = true,
					no_ignore = true,
				})
			end, { desc = 'Find Files' })

			utils.mapKey('Telescope', 'n', '<leader>fhf', function()
				builtin.find_files({
					find_command = {
						'rg',
						'--files',
					},
					hidden = true,
					no_ignore = true,
				})
			end, { desc = 'Find Files' })

			utils.mapKey('Telescope', 'n', '<leader>fhw', function()
				builtin.live_grep({
					additional_args = {
						'--hidden',
						'--no-ignore',
					},
				})
			end, { desc = 'Grep All Text' })

			utils.mapKey('Telescope', 'n', '<leader>fw', builtin.live_grep, { desc = 'Grep Text' })
			utils.mapKey('Telescope', 'n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
			utils.mapKey('Telescope', 'n', '<leader>fm', builtin.marks, { desc = 'Marks' })
			utils.mapKey('Telescope', 'n', '<leader>fc', builtin.git_commits, { desc = 'Git Commits' })
			utils.mapKey('Telescope', 'n', '<leader>fs', builtin.builtin, { desc = 'Select Telescope' })
			utils.mapKey('Telescope', 'n', '<leader>fg', builtin.git_status, { desc = 'Git Status' })
			utils.mapKey('Telescope', 'n', '<leader>fd', builtin.diagnostics, { desc = '[D]iagnostics' })
			utils.mapKey('Telescope', 'n', '<leader>fk', builtin.keymaps, { desc = '[K]eymaps' })
		end,
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable('make') == 1
				end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },
			{ 'nvim-tree/nvim-web-devicons' },
		},
	},
}
