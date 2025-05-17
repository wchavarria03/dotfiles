return {
    'echasnovski/mini.nvim',
    version = false,
    event = 'VeryLazy',
    keys = {
        {
            '<leader>e',
            function()
                require('mini.files').open(vim.api.nvim_buf_get_name(0), false)
                require('mini.files').reveal_cwd()
            end,
            desc = 'Toggle Explorer Current File',
        },
        {
            '<leader>E',
            function()
                require('mini.files').open()
            end,
            desc = 'Toggle Explorer Directory',
        },
        -- TODO: Add keys to copy current cwd and relative path
        -- Look into the help for mini.files for examples
    },
    opts = {
        mappings = {
            go_in = '<CR>',
            go_in_plus = 'L',
            go_out = '-',
            go_out_plus = 'H',
        },
        options = {
            parmanent_delete = false,
            use_as_default_explorer = true,
        },
    },
    config = function(_, opts)
        require('mini.files').setup(opts)
    end,
}
