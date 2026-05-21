local M = {}

M.plugins = {
    'https://github.com/folke/ts-comments.nvim',
}

function M.setup()
    require('ts-comments').setup {}
end

return M
