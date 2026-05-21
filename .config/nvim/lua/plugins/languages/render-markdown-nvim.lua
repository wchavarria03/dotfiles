local M = {}

M.plugins = {
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}

function M.setup()
    require('render-markdown').setup {
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
end

return M
