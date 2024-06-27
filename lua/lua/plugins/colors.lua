return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			flavour = "mocha",
			integrations = {
				cmp = true,
				fidget = true,
				flash = false,
				harpoon = false,
				mason = true,
				notify = true,
				octo = true,
				which_key = true,
				telescope = {
					enabled = true,
				},
				mini = {
					enabled = true,
					indentscope_color = "", -- catppuccin color (eg. `lavender`) Default: text
				},
			},
			dim_inactive = {
				enabled = true,
				percentage = 0.60,
				shade = "light",
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin-mocha")
			-- vim.api.nvim_command("highlight VertSplit guifg=#95bb92")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		cmd = {
			"TSInstall",
			"TSInstallInfo",
			"TSUpdate",
			"TSBufEnable",
			"TSBufDisable",
			"TSEnable",
			"TSDisable",
			"TSModuleInfo",
		},
		opts = {
			autopairs = {
				enable = true,
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			ensure_installed = {
				"bash",
				"css",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"regex",
				"ruby",
				"scss",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>ss",
					node_incremental = "<leader>si",
					node_decremental = "<leader>sd",
					scope_incremental = "<leader>ssi",
				},
			},
			indent = {
				enable = true,
				disable = { "ruby" },
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{ "numToStr/Comment.nvim", opts = {} },
}
