-----------------------------------------------------------
-- Statusline configuration file ---------------------------------------------------------
-----------------------------------------------------------

local function empty_component()
	return '%='
end

return {
	{
		'nvim-lualine/lualine.nvim',
		event = 'VeryLazy',
		init = function()
			-- disable until lualine loads
			vim.opt.laststatus = 0
		end,
		opts = {},
		config = function(_, opts)
			-- Get the default options
			require('lualine').setup({
				options = vim.tbl_extend('force', opts, {
					theme = 'catppuccin',
					disabled_filetypes = {
						'NvimTree',
						statusline = {},
						winbar = {},
					},
					extensions = { 'nvim-tree' },
					filetypes = { 'NvimTree' },
				}),
				sections = {
					lualine_a = {
						{
							'mode',
						},
					},
					lualine_b = { 'branch', 'diff', 'diagnostics' },
					-- lualine_b = {'branch', harpoon_component, 'diff', 'diagnostics'},
					lualine_c = {
						{ 'filename', path = 1 },
					},
					lualine_x = { 'filetype' },
					lualine_y = { 'progress' },
					lualine_z = { 'location' },
				},
				inactive_sections = {
					lualine_a = {
						{
							'filename',
							path = 1,
							color = { fg = '#000000', bg = '#9cdf9b' },
						},
					},
					lualine_b = {
						{
							empty_component,
							color = { fg = '#000000', bg = '#9cdf9b' },
						},
					},
					lualine_c = {
						{
							empty_component,
							color = { fg = '#000000', bg = '#9cdf9b' },
						},
					},
					lualine_x = {
						{
							'location',
							color = { fg = '#000000', bg = '#9cdf9b' },
						},
					},
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
		dependencies = { 'ThePrimeagen/harpoon' },
	},
}
