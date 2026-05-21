local M = {}

M.plugins = {
    'https://github.com/m4xshen/hardtime.nvim',
}

function M.setup()
    -- dependencies = { 'MunifTanjim/nui.nvim' },
    require('hardtime').setup {}
    vim.g.hardtime = true

    require('snacks').toggle
        .new({
            id = 'HardTime',
            name = 'HardTime',
            get = function()
                return vim.g.hardtime
            end,
            set = function()
                vim.cmd 'Hardtime toggle'
                vim.g.hardtime = not vim.g.hardtime
            end,
        })
        :map '<leader>tH'
end

return M
