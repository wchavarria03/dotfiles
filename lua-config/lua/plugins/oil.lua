return {
	{
		'stevearc/oil.nvim',
		opts = {},
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('oil').setup({
				delete_to_trash = true,
				skip_confirmation_for_simple = true,
				view_options = {
					show_hidden = true,
				},
				win_options = {
					wrap = true,
				},
			})

			vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Edit: On Parent Directory' })
			vim.keymap.set('n', '<space>-', require('oil').toggle_float, { desc = 'Edit: On Parent Directory Float' })
		end,
	},
}
