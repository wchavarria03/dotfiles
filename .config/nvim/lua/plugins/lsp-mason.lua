return {
	{
		'williamboman/mason.nvim',
		dependencies = {
			'williamboman/mason-lspconfig.nvim',
		},
		opts = {
			ui = {
				border = 'single',
				icons = {
					package_installed = '✓',
					package_pending = '➜',
					package_uninstalled = '✗',
				},
			},
		},
		config = function(_, opts)
			local mason = require('mason')
			local mason_lspconfig = require('mason-lspconfig')

			mason.setup(opts)
			mason_lspconfig.setup({
				ensure_installed = {
					-- LSPs
					'ts_ls',
					'lua_ls',

					'bashls',
					'dockerls',
					'jsonls',

					'gopls',
					'pyright',

					-- 'beancount', -- installed using homebrew because of errors on the one installed on Mason
				},
			})
		end,
	},
}
