return {
    'b0o/incline.nvim',
    event = 'BufReadPre',
    config = function()
        local helpers = require 'incline.helpers'
        local devicons = require 'nvim-web-devicons'

        require('incline').setup {
            highlight = {
                groups = {
                    InclineNormal = { default = true, group = 'lualine_a_normal' },
                    InclineNormalNC = { default = true, group = 'Comment' },
                },
            },

            window = {
                margin = { vertical = 0, horizontal = 1 },
            },

            render = function(props)
                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
                if filename == '' then
                    filename = '[No Name]'
                end
                local icon, color = devicons.get_icon_color(filename)
                -- local modified = vim.bo[props.buf].modified
                -- return {
                --     ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
                --     ' ',
                --     { filename, gui = modified and 'bold,italic' or 'bold' },
                --     ' ',
                --     guibg = '#44406e',
                -- }
                return { { icon, guifg = color }, { icon and ' ' or '' }, { filename } }
            end,
        }
    end,
}
