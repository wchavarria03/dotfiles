local M = {}

M.plugins = {
    'https://github.com/copilotlsp-nvim/copilot-lsp',
}

function M.setup()
    vim.g.copilot_nes_debounce = 500
    vim.lsp.enable 'copilot_ls'

    require('copilot-lsp').setup {}

    vim.keymap.set('i', '<C-y>', function()
        local bufnr = vim.api.nvim_get_current_buf()
        local state = vim.b[bufnr].nes_state

        if state then
            local _ = require('copilot-lsp.nes').walk_cursor_start_edit()
                or (require('copilot-lsp.nes').apply_pending_nes() and require('copilot-lsp.nes').walk_cursor_end_edit())
            return nil
        else
            return '<C-i>'
        end
    end, { desc = 'Accept Copilot NES suggestion', expr = true })

    vim.keymap.set('i', '<esc>', function()
        require('copilot-lsp.nes').clear()
    end, { desc = 'Clear Copilot suggestion or fallback' })
end

return M
