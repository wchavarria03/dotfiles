local utils = require('config.utils')

local M = {}

M.setup = function(event)
	local keymap = vim.keymap
	local opts = { noremap = true, silent = true, buffer = event.buf }

	opts.desc = 'LSP: [G]o [D]eclaration'
	keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

	opts.desc = 'LSP: [G]o [D]efinition'
	keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)

	opts.desc = 'LSP: [G]o [I]mplementation'
	keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

	opts.desc = 'LSP: [G]o [R]eferences'
	keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)

	opts.desc = 'LSP: Hover Doc'
	keymap.set('n', 'K', vim.lsp.buf.hover, opts)

	opts.desc = 'LSP: [T]ype [D]efinition'
	keymap.set('n', '<leader>D', '<cmd>Telescope lsp_type_definitions<CR>', opts)

	opts.desc = 'LSP: Signature'
	keymap.set('n', '<C-d>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

	opts.desc = 'LSP: [C]ode [a]ction'
	keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

	opts.desc = 'LSP: [C]ode [A]ction Range'
	keymap.set('x', '<leader>cA', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', opts)

	opts.desc = 'LSP: [R]e[n]ame'
	keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)

	opts.desc = 'LSP: Diagnostic Modal'
	keymap.set('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)

	opts.desc = 'LSP: Buffer Diagnostics'
	keymap.set('n', '<leader>dl', '<cmd>Telescope diagnostics<CR>', opts)

	opts.desc = 'LSP: Diagnostic Prev'
	keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)

	opts.desc = 'LSP: Diagnostic Next'
	keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)

	opts.desc = 'LSP: Restart LSP'
	keymap.set('n', '<leader>rs', ':LspRestart<cr>', opts)
end

return M
