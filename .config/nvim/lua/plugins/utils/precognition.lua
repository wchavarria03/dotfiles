vim.pack.add {
    'https://github.com/tris203/precognition.nvim',
}

require('precognition').setup {
    startVisible = false,
}

-- TODO: Check if snacks is loaded or how to difer this
require('snacks')
    .toggle({
        name = 'Precognition',
        get = function()
            return not vim.g.precognition
        end,
        set = function(state)
            vim.g.precognition = not state
            require('precognition').toggle(state)
        end,
    })
    :map '<leader>tP'
