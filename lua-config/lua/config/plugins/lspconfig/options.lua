local M = {}

M.setup = function()
	vim.diagnostic.config({
		virtual_text = true,
		float = {
			header = false,
			border = 'rounded',
			focusable = true,
		},
	})
	local _border = 'single'
	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = _border })
	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

	local lspconfig = require('lspconfig')
	local cmp_nvm_lsp = require('cmp_nvim_lsp')
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvm_lsp.default_capabilities())

	lspconfig.gopls.setup({
		capabilities = capabilities,
		settings = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
				staticcheck = true,
			},
		},
	})

	lspconfig.pyright.setup({
		capabilities = capabilities,
	})

	lspconfig.bashls.setup({
		capabilities = capabilities,
	})

	lspconfig.dockerls.setup({
		capabilities = capabilities,
	})

	lspconfig.jsonls.setup({
		capabilities = capabilities,
	})

	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { 'vim', 'use', 'group' },
				},
			},
		},
	})

	lspconfig.tsserver.setup({
		capabilities = capabilities,
		settings = {
			completions = {
				completeFunctionCalls = true,
			},
		},
	})
end

return M
