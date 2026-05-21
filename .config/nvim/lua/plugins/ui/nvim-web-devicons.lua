local M = {}

M.plugins = {
    'https://github.com/echasnovski/mini.nvim',
}

function M.setup()
    require('mini.icons').setup {}
    MiniIcons.mock_nvim_web_devicons()
end

return M
