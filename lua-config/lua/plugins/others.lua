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
}
