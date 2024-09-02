local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
end

return {
	{
		'hrsh7th/nvim-cmp',
		event = { 'InsertEnter', 'CmdlineEnter' },
		dependencies = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			{
				'L3MON4D3/LuaSnip',
				version = 'v2.*',
				build = 'make install_jsregexp',
			},
			'saadparwaiz1/cmp_luasnip',
			'rafamadriz/friendly-snippets',

			'zbirenbaum/copilot-cmp',

			'onsails/lspkind-nvim',
		},
		config = function()
			local cmp = require('cmp')
			local luaSnip = require('luasnip')
			local lspkind = require('lspkind')

			require('luasnip.loaders.from_vscode').lazy_load()

			local sorting = require('cmp.config.default')().sorting
			sorting.comparators = {
				require('copilot_cmp.comparators').prioritize,
			}

			cmp.setup({
				completion = {
					completept = 'menu,menuone,preview,noselect',
				},
				snippet = {
					expand = function(args)
						luaSnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-k>'] = cmp.mapping.select_prev_item(),
					['<C-j>'] = cmp.mapping.select_next_item(),
					['<C-h>'] = cmp.mapping.scroll_docs(-4),
					['<C-l>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-y>'] = cmp.config.disable,
					-- ['<esc>'] = cmp.mapping({
					-- 	i = cmp.mapping.abort(),
					-- 	c = cmp.mapping.close(),
					-- }),
					['<CR>'] = cmp.mapping.confirm({ select = false }),
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
						elseif require('copilot.suggestion').is_visible() then
							require('copilot.suggestion').accept()
						elseif luaSnip.expand_or_locally_jumpable() then
							luaSnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function()
						if luaSnip.locally_jumpable(-1) then
							luaSnip.jump(-1)
						end
					end, { 'i', 's' }),
				}),
				sources = cmp.config.sources({
					{ name = 'copilot', group_index = 2, priority = 60 },
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				}, {
					{ name = 'buffer', keyword_length = 3 },
					{ name = 'path' },
					{ name = 'treesitter' },
				}),
				sorting = sorting,
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
					preview = cmp.config.window.bordered(),
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = 'symbol_text',
						maxwidth = 50,
						ellipsis_char = '...',
						show_labelDetails = true,
						symbol_map = { Copilot = '' },
					}),
				},
			})
		end,
	},
	{
		'zbirenbaum/copilot-cmp',
		event = { 'InsertEnter', 'LspAttach', 'CmdlineEnter' },
		dependencies = { 'zbirenbaum/copilot.lua' },
		opts = {},
	},
}
