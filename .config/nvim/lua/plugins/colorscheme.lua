return {
	'catppuccin/nvim',
	lazy = false,
	priority = 1000,
	opts = {
		flavour = 'mocha',
		integrations = {
			aerial = true,
			alpha = true,
			cmp = true,
			dashboard = true,
			fidget = true,
			flash = true,
			gitsigns = true,
			harpoon = false,
			headlines = true,
			illuminate = true,
			indent_blankline = { enabled = true },
			leap = true,
			lsp_trouble = true,
			markdown = true,
			mason = true,
			mini = true,
			native_lsp = {
				enabled = true,
				underlines = {
					errors = { 'undercurl' },
					hints = { 'undercurl' },
					warnings = { 'undercurl' },
					information = { 'undercurl' },
				},
			},
			navic = { enabled = true, custom_bg = 'lualine' },
			neotest = true,
			neotree = true,
			noice = true,
			notify = true,
			semantic_tokens = true,
			telescope = true,
			treesitter = true,
			treesitter_context = true,
			which_key = true,
		},
		dim_inactive = {
			enabled = true,
			percentage = 0.60,
			shade = 'light',
		},
	},
	config = function(_, opts)
		require('catppuccin').setup(opts)
		vim.cmd.colorscheme('catppuccin-mocha')
	end,
}
