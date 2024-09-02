return {
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		build = ':Copilot auth',
		event = 'InsertEnter',
		config = function()
			require('copilot').setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		'CopilotC-Nvim/CopilotChat.nvim',
		branch = 'canary',
		dependencies = {
			{ 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
			{ 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
		},
		opts = {},
	},
}
