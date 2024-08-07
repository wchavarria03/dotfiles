local utils = require('config.utils')
local merge_tb = vim.tbl_deep_extend

return {
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			-- Creates a beautiful debugger UI
			'rcarriga/nvim-dap-ui',

			-- Required dependency for nvim-dap-ui
			'nvim-neotest/nvim-nio',

			-- Installs the debug adapters for you
			'williamboman/mason.nvim',
			'jay-babu/mason-nvim-dap.nvim',

			-- Add your own debuggers here
			'leoluz/nvim-dap-go',
		},
		config = function()
			local dap = require('dap')
			local dapui = require('dapui')

			require('mason-nvim-dap').setup({
				automatic_installation = true,

				handlers = {},

				ensure_installed = {
					'js-debug-adapter',
					'chrome-debug-adapter',
					'debugpy',
					'delve',
				},
			})

			local opts = { noremap = true, silent = true, nowait = true }

			utils.mapKey('Debug', 'n', '<F5>', dap.continue, merge_tb('force', opts, { desc = 'Start/Continue' }))
			utils.mapKey('Debug', 'n', '<F1>', dap.step_into, merge_tb('force', opts, { desc = 'Step Into' }))
			utils.mapKey('Debug', 'n', '<F2>', dap.step_over, merge_tb('force', opts, { desc = 'Step Over' }))
			utils.mapKey('Debug', 'n', '<F3>', dap.step_out, merge_tb('force', opts, { desc = 'Step Out' }))
			utils.mapKey(
				'Debug',
				'n',
				'<leader>db',
				dap.toggle_breakpoint,
				merge_tb('force', opts, { desc = 'Toggle [B]reakpoint' })
			)
			utils.mapKey('[D]ebug', 'n', '<leader>dB', function()
				dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
			end, { desc = '[D]ebug: Set [B]reakpoint' })

			-- Dap UI setup
			-- For more information, see |:help nvim-dap-ui|
			dapui.setup({
				-- Set icons to characters that are more likely to work in every terminal.
				--    Feel free to remove or use ones that you like more! :)
				--    Don't feel like these are good choices.
				icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
				controls = {
					icons = {
						pause = '⏸',
						play = '▶',
						step_into = '⏎',
						step_over = '⏭',
						step_out = '⏮',
						step_back = 'b',
						run_last = '▶▶',
						terminate = '⏹',
						disconnect = '⏏',
					},
				},
			})

			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

			dap.listeners.after.event_initialized['dapui_config'] = dapui.open
			dap.listeners.before.event_terminated['dapui_config'] = dapui.close
			dap.listeners.before.event_exited['dapui_config'] = dapui.close

			-- Install golang specific config
			require('dap-go').setup({})
		end,
	},
}
