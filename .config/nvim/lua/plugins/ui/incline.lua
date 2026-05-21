-- local devicons = require 'nvim-web-devicons'

local M = {}

M.plugins = {
    'https://github.com/b0o/incline.nvim',
}

function M.setup()
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

        -- render = function(props)
        --     local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        --     if filename == '' then
        --         filename = '[No Name]'
        --     end
        --     local icon, color = devicons.get_icon_color(filename)
        --     return { { icon, guifg = color }, { icon and ' ' or '' }, { filename } }
        -- end,
    }
end

return M
