local M = {}

M.copilot_status = function()
    local clients = vim.lsp.get_clients { name = 'copilot', bufnr = 0 }
    if #clients > 0 then
        local status = require('copilot.api').status.data.status
        return (status == 'InProgress' and '...')
            or (status == 'Warning' and 'X')
            or ''
    end
    return ''
end

return M