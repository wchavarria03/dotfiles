return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		event = { 'VeryLazy' },
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
			-- no longer trigger the **nvim-treesitter** module to be loaded in time.
			-- Luckily, the only things that those plugins need are the custom queries, which we make available
			-- during startup.
			require('lazy.core.loader').add_to_rtp(plugin)
			require('nvim-treesitter.query_predicates')
		end,
		cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
		opts = {
			autopairs = { enable = true },
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				'bash',
				'javascript',
				'jsdoc',
				'json',
				'markdown',
				'markdown_inline',
				'regex',
				'tsx',
				'typescript',
				'vim',
				'vimdoc',
				'beancount',

				-- Lua
				'lua',
				'luadoc',

				-- GO
				'go',
				'gomod',
				'gosum',
				'gowork',
				'gotmpl',

				-- python
				'python',
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<leader>ss',
					node_incremental = '<leader>si',
					node_decremental = '<leader>sd',
					scope_incremental = '<leader>ssi',
				},
			},
		},
		config = function(_, opts)
			require('nvim-treesitter.install').prefer_git = true
			require('nvim-treesitter.configs').setup(opts)
		end,
	},
}
