local keymaps = require('../config/plugins/lsp/keymaps')
local options = require('../config/plugins/lsp/options')

return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		{ 'antosha417/nvim-lsp-file-operations', config = true },
	},
	config = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
			callback = function(event)
				keymaps.setup(event)
			end,
		})
		options.setup()
	end,
}
