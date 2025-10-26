local utils = require 'plugins.lsp.utils'

utils.set_lsp_capabilities()
utils.set_diagnostic_config()

vim.keymap.set('n', '<leader>ln', function()
    utils.print_active_lsp_names(0)
end, { desc = 'Show LSP Names' })

vim.keymap.set('n', '<leader>li', function()
    utils.print_detailed_lsp_info(0)
end, { desc = 'Show Detailed LSP Info' })

require 'plugins.lsp.mason'
