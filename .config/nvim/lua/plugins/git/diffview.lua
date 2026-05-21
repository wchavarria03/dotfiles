local M = {}

M.plugins = {
    'https://github.com/sindrets/diffview.nvim',
}


function M.setup()
    -- Detach LSP from diffview virtual buffers after setup is complete to avoid
    -- a race condition in _changetracking.lua when diffview renders its panels
    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            local bufname = vim.api.nvim_buf_get_name(args.buf)
            if bufname:match '^diffview://' then
                vim.schedule(function()
                    vim.lsp.buf_detach_client(args.buf, args.data.client_id)
                end)
            end
        end,
    })

    require('diffview').setup {
        view = {
            default = {
                layout = 'diff2_horizontal',
            },
            merge_tool = {
                layout = 'diff3_horizontal',
            },
        },
    }

    vim.keymap.set('n', '<leader>gv', '<cmd>DiffviewOpen<cr>', { desc = 'Git diff view' })
    vim.keymap.set('n', '<leader>gV', '<cmd>DiffviewOpen HEAD~1<cr>', { desc = 'Git diff vs last commit' })
    vim.keymap.set('n', '<leader>gf', '<cmd>DiffviewFileHistory %<cr>', { desc = 'Git file history (current)' })
    vim.keymap.set('n', '<leader>gF', '<cmd>DiffviewFileHistory<cr>', { desc = 'Git file history (repo)' })
    vim.keymap.set('n', '<leader>gx', '<cmd>DiffviewClose<cr>', { desc = 'Git diff close' })
end

return M
