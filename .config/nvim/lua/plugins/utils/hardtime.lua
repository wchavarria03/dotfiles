local M = {}

M.plugins = {
    'https://github.com/m4xshen/hardtime.nvim',
}

function M.setup()
    -- dependencies = { 'MunifTanjim/nui.nvim' },
    require('hardtime').setup {}
    vim.g.hardtime = true
end

return M
