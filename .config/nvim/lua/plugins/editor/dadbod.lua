vim.pack.add {
    'https://github.com/tpope/vim-dadbod',
    'https://github.com/kristijanhusak/vim-dadbod-ui',
    'https://github.com/kristijanhusak/vim-dadbod-completion',
}

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_save_location = vim.fn.stdpath 'data' .. '/db_ui'
vim.g.db_ui_auto_execute_table_helpers = 1
vim.g.db_ui_tmp_query_location = vim.fn.stdpath 'data' .. '/db_ui/tmp'

-- SQL completion via omnifunc
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'sql', 'mysql', 'plsql' },
    callback = function()
        vim.bo.omnifunc = 'vim_dadbod_completion#omni'
    end,
})

vim.keymap.set('n', '<leader>db', '<cmd>DBUIToggle<cr>', { desc = 'Toggle DB UI' })
vim.keymap.set('n', '<leader>df', '<cmd>DBUIFindBuffer<cr>', { desc = 'DB Find Buffer' })
vim.keymap.set('n', '<leader>dl', '<cmd>DBUILastQueryInfo<cr>', { desc = 'DB Last Query Info' })
