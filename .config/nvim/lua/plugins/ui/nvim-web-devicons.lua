local M = {}

M.plugins = {
    'https://github.com/nvim-tree/nvim-web-devicons',
}

function M.setup()
    require("nvim-web-devicons").setup()
end

return M
