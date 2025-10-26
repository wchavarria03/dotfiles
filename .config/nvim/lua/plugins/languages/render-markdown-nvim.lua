vim.pack.add {
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}

require('render-markdown').setup {
    -- TODO: Check dependencies for this one since, just check the order is correct
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    code = {
        sign = false,
        width = 'block',
        right_pad = 1,
    },
    file_types = { 'markdown' },
    completions = {
        blink = { enabled = true },
    },
    latex = { enabled = false },
}

-- TODO: Check if snacks is already loaded or if we need to delay this call
require('snacks')
    .toggle({
        name = 'Render Markdown',
        get = function()
            return require('render-markdown.state').enabled
        end,
        set = function(enabled)
            local m = require 'render-markdown'
            if enabled then
                m.enable()
            else
                m.disable()
            end
        end,
    })
    :map '<leader>tm'
