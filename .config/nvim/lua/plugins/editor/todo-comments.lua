vim.pack.add { 'https://github.com/folke/todo-comments.nvim' }

require('todo-comments').setup {
    keys = {
        {
            ']t',
            function()
                require('todo-comments').jump_next()
            end,
            desc = 'Next Todo Comment',
        },
        {
            '[t',
            function()
                require('todo-comments').jump_prev()
            end,
            desc = 'Previous Todo Comment',
        },
        { '<leader>xt', '<cmd>Trouble todo toggle<cr>', desc = 'Todo (Trouble)' },
        {
            '<leader>xT',
            '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>',
            desc = 'Todo/Fix/Fixme (Trouble)',
        },
        {
            '<leader>st',
            function()
                require('snacks').picker.todo_comments()
            end,
            desc = 'Todos',
        },
        {
            '<leader>sT',
            function()
                require('snacks').picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } }
            end,
            desc = 'Todo/Fix/Fixme',
        },
    },
}
