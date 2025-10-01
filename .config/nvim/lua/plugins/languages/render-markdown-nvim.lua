return {
    'MeanderingProgrammer/render-markdown.nvim',
    event = 'VeryLazy',
    opts = {
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
    },
    ft = { 'markdown' },
    config = function(_, opts)
        require('render-markdown').setup(opts)
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
    end,
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
}
