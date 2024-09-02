return {
	{
		'stevearc/conform.nvim',
		dependencies = { 'mason.nvim' },
		priority = 100,
		event = 'VeryLazy',
		cmd = 'ConformInfo',
		keys = {
			{
				'<leader>cf',
				function()
					require('conform').format({ formatters = { 'injected' }, timeout_ms = 3000 })
					-- require('conform').format({ async = true, lsp_fallback = true })
				end,
				mode = { 'n', 'v' },
				desc = 'Formatter: [C]ode [F]ormat Buffer',
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { 'stylua' },
				python = { 'black', 'isort' },
				go = { 'gofumpt', 'goimports-reviser', 'golines' },
				['*'] = { 'codespell' },
			},
			format_on_save = {
				timeout_ms = 3000,
				async = false,
				quiet = false,
				lsp_format = 'fallback',
			},
		},
	},
	{
		'zapling/mason-conform.nvim',
		opts = {},
	},
}
