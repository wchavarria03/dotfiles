return {
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
}
