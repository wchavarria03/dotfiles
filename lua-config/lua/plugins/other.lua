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
}
