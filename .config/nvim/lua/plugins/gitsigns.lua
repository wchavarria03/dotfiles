local setKeymaps = function(buffer)
	local gs = require('gitsigns')

	local map = function(mode, lhs, rhs, opts)
		opts = opts or {}
		opts.buffer = buffer
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	map('n', ']c', gs.next_hunk, { desc = '[G]it: Next Hunk' })
	map('n', '[c', gs.prev_hunk, { desc = '[G]it: Prev Hunk' })
	map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk', { desc = '[G]it: [S]tage Hunk' })
	map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk', { desc = '[G]it: [R]eset Hunk' })
	map('n', '<leader>gu', gs.undo_stage_hunk, { desc = '[G]it: [U]ndo Stage Hunk' })
	map('n', '<leader>gS', gs.stage_buffer, { desc = '[G]it: [S]tage Buffer' })
	map('n', '<leader>gR', gs.reset_buffer, { desc = '[G]it: [R]eset Buffer' })
	map('n', '<leader>gp', gs.preview_hunk, { desc = '[G]it: [P]review Hunk' })

	map('n', '<leader>gb', function()
		gs.blame_line({ full = true })
	end, { desc = '[G]it [B]lame Line' })

	map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = '[G]it [T]oggle [B]lame Line' })
	map('n', '<leader>gd', gs.diffthis, { desc = '[G]it [D]iff This' })

	map('n', '<leader>gD', function()
		gs.diffthis('~')
	end, { desc = '[G]it [D]iff This ~' })

	map('n', '<leader>gtd', gs.toggle_deleted, { desc = '[G]it [T]oggle [D]eleted' })
end

return {
	{
		'lewis6991/gitsigns.nvim',
		event = { 'BufReadPost', 'BufNewFile' },
		ft = 'gitcommit',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			preview_config = {
				border = 'rounded',
			},
			on_attach = function(buffer)
				setKeymaps(buffer)
			end,
		},
	},
}
