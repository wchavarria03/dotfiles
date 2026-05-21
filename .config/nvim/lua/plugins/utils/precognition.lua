local M = {}

M.plugins = {
    'https://github.com/tris203/precognition.nvim',
}

function M.setup()
    require('precognition').setup {
        startVisible = false,
    }

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
end

return M
