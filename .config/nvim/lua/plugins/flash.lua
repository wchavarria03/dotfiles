return {
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
				desc = 'Jump: Flash',
			},
			{
				'S',
				mode = { 'n', 'o', 'x' },
				function()
					require('flash').treesitter()
				end,
				desc = 'Jump: Flash Treesitter',
			},
			{
				'r',
				mode = 'o',
				function()
					require('flash').remote()
				end,
				desc = 'Jump: Remote Flash',
			},
		},
	},
}
