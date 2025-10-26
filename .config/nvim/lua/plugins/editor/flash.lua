vim.pack.add { 'https://github.com/folke/flash.nvim' }

require('flash').setup {
    modes = {
        search = { enabled = true },
        char = {
            enabled = false,
        },
    },
    keys = {
        {
            'S',
            mode = { 'n', 'o', 'x' },
            function()
                require('flash').treesitter()
            end,
            desc = 'Flash Treesitter',
        },
        {
            'r',
            mode = 'o',
            function()
                require('flash').remote()
            end,
            desc = 'Remote Flash',
        },
        {
            'R',
            mode = { 'o', 'x' },
            function()
                require('flash').treesitter_search()
            end,
            desc = 'Treesitter Search',
        },
        {
            '<c-s>',
            mode = { 'c' },
            function()
                require('flash').toggle()
            end,
            desc = 'Toggle Flash Search',
        },
    },
}

vim.keymap.set({ 'n', 'x', 'o' }, 'f', function()
    require('flash').jump()
end, { desc = 'Flash' })

vim.keymap.set({ 'n', 'x', 'o' }, 'S', function()
    require('flash').treesitter()
end, { desc = 'Flash Treesitter' })

vim.keymap.set('o', 'r', function()
    require('flash').remote()
end, { desc = 'Remote Flash' })

vim.keymap.set({ 'o', 'x' }, 'R', function()
    require('flash').treesitter_search()
end, { desc = 'Treesitter Search' })
