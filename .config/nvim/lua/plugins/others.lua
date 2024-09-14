return {
	{
		'iamcco/markdown-preview.nvim',
		cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
		ft = { 'markdown' },
		build = function()
			vim.fn['mkdp#util#install']()
		end,
	},
	{
		'folke/zen-mode.nvim',
		event = 'VeryLazy',
		opts = {},
	},
	{
		'folke/twilight.nvim',
		event = 'VeryLazy',
		opts = {},
	},
	{
		'nvim-zh/colorful-winsep.nvim',
		config = true,
		event = { 'WinLeave' },
	},
	{ 'numToStr/Comment.nvim', opts = {} },
	{
		'j-hui/fidget.nvim',
		opts = {},
	},
	{
		'folke/todo-comments.nvim',
		cmd = { 'TodoTrouble', 'TodoTelescope' },
		event = 'VeryLazy',
		opts = {},
		keys = {
			{ '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'TODO: [S]earch [T]odo' },
			{ '<leader>sT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = 'TODO: Todo/Fix/Fixme' },
		},
	},
	{
		'mrjones2014/smart-splits.nvim',
		opts = {
			float_win_behavior = 'mux',
		},
		config = function(opts)
			vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
			vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
			vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
			vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)

			vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
			vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
			vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
			vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)

			require('smart-splits').setup({ float_win_behavior = 'mux' })
		end,
	},
}
