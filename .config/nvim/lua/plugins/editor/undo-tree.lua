local M = {}

M.plugins = {}

function M.setup()
    vim.cmd.packadd 'nvim.undotree'

    vim.keymap.set('n', '<leader>uu', function()
        require('undotree').open {
            command = 'topleft 30vnew',
            title = 'Undotree Viewer',
        }
    end, { desc = 'Open Undo Tree', silent = true })
end

return M
