local M = {}

M.plugins = {
    'https://github.com/folke/todo-comments.nvim',
}

function M.setup()
    require('todo-comments').setup {}

    vim.keymap.set('n', ']t', function()
        require('todo-comments').jump_next()
    end, { desc = 'Next Todo Comment' })

    vim.keymap.set('n', '[t', function()
        require('todo-comments').jump_prev()
    end, { desc = 'Previous Todo Comment' })

    vim.keymap.set('n', '<leader>xt', '<cmd>Trouble todo toggle<cr>', { desc = 'Todo (Trouble)' })
    vim.keymap.set('n', '<leader>xT', '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>', { desc = 'Todo/Fix/Fixme (Trouble)' })

    vim.keymap.set('n', '<leader>st', function()
        require('snacks').picker.todo_comments()
    end, { desc = 'Todos' })

    vim.keymap.set('n', '<leader>sT', function()
        require('snacks').picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } }
    end, { desc = 'Todo/Fix/Fixme' })
end

return M
