local M = {}

function M.set_lsp_capabilities()
    local ok, blink_cmp = pcall(require, 'blink.cmp')
    if ok then
        vim.lsp.config('*', {
            capabilities = blink_cmp.get_lsp_capabilities(),
            root_markers = { '.git' },
        })
    else
        vim.lsp.config('*', {
            root_markers = { '.git' },
        })
    end
end

function M.set_diagnostic_config()
    vim.diagnostic.config {
        underline = true,
        update_in_insert = false,
        virtual_text = true,
        severity_sort = true,
        float = {
            border = 'rounded',
            source = true,
        },
    }
end

return M
