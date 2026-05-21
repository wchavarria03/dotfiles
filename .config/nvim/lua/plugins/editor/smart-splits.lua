local M = {}

M.plugins = {
    'https://github.com/mrjones2014/smart-splits.nvim',
}

function M.setup()
    local smart_splits = require 'smart-splits'

    smart_splits.setup {
        ignored_buftypes = {
            'nofile',
            'quickfix',
            'prompt',
        },
        ignored_filetypes = { 'NvimTree' },
        default_amount = 3,
        at_edge = 'wrap',
        float_win_behavior = 'previous',
        move_cursor_same_row = false,
        cursor_follows_swapped_bufs = false,
        resize_mode = {
            quit_key = '<ESC>',
            resize_keys = { 'h', 'j', 'k', 'l' },
            silent = false,
            hooks = {
                on_enter = nil,
                on_leave = nil,
            },
        },
        ignored_events = {
            'BufEnter',
            'WinEnter',
        },
        multiplexer_integration = nil,
        disable_multiplexer_nav_when_zoomed = true,
    }

    vim.keymap.set('n', '<C-h>', smart_splits.move_cursor_left, { desc = 'Move to left split' })
    vim.keymap.set('n', '<C-j>', smart_splits.move_cursor_down, { desc = 'Move to below split' })
    vim.keymap.set('n', '<C-k>', smart_splits.move_cursor_up, { desc = 'Move to above split' })
    vim.keymap.set('n', '<C-l>', smart_splits.move_cursor_right, { desc = 'Move to right split' })

    vim.keymap.set('n', '<leader>rh', smart_splits.resize_left, { desc = 'Resize split left' })
    vim.keymap.set('n', '<leader>rj', smart_splits.resize_down, { desc = 'Resize split down' })
    vim.keymap.set('n', '<leader>rk', smart_splits.resize_up, { desc = 'Resize split up' })
    vim.keymap.set('n', '<leader>rl', smart_splits.resize_right, { desc = 'Resize split right' })

    vim.keymap.set('n', '<leader><leader>h', smart_splits.swap_buf_left, { desc = 'Swap buffer left' })
    vim.keymap.set('n', '<leader><leader>j', smart_splits.swap_buf_down, { desc = 'Swap buffer down' })
    vim.keymap.set('n', '<leader><leader>k', smart_splits.swap_buf_up, { desc = 'Swap buffer up' })
    vim.keymap.set('n', '<leader><leader>l', smart_splits.swap_buf_right, { desc = 'Swap buffer right' })
end

return M
