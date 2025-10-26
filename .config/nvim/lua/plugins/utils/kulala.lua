vim.pack.add {
    'https://github.com/mistweaverco/kulala.nvim',
}

-- ft = { 'http', 'rest' },

require('kulala').setup {
    default_view = 'body',
    global_keymaps_prefix = '<leader>R',
    debug = false,
    contenttypes = {
        ['application/json'] = {
            ft = 'json',
            formatter = { 'jq', '.' },
        },
        ['application/xml'] = {
            ft = 'xml',
            formatter = { 'xmllint', '--format', '-' },
        },
        ['text/html'] = {
            ft = 'html',
            formatter = { 'xmllint', '--format', '--html', '-' },
        },
    },
}

-- {
--     '<leader>kr',
--     function()
--         require('kulala').run()
--     end,
--     desc = 'Kulala: Run request',
-- },
-- {
--     '<leader>ki',
--     function()
--         require('kulala').inspect()
--     end,
--     desc = 'Kulala: Inspect request',
-- },
-- {
--     '<leader>kt',
--     function()
--         require('kulala').toggle_view()
--     end,
--     desc = 'Kulala: Toggle view',
-- },
-- {
--     '<leader>kc',
--     function()
--         require('kulala').copy()
--     end,
--     desc = 'Kulala: Copy as cURL',
-- },
-- {
--     '<leader>kp',
--     function()
--         require('kulala').from_curl()
--     end,
--     desc = 'Kulala: Paste from cURL',
-- },
-- {
--     '<leader>kn',
--     function()
--         require('kulala').jump_next()
--     end,
--     desc = 'Kulala: Jump to next request',
-- },
-- {
--     '<leader>kP',
--     function()
--         require('kulala').jump_prev()
--     end,
--     desc = 'Kulala: Jump to previous request',
-- },
-- {
--     '<leader>ks',
--     function()
--         require('kulala').scratchpad()
--     end,
--     desc = 'Kulala: Open scratchpad',
-- },
-- {
--     '<leader>ke',
--     function()
--         require('kulala').set_selected_env()
--     end,
--     desc = 'Kulala: Select environment',
-- },
-- {
--     '<leader>km',
--     function()
--         require('kulala').import()
--     end,
--     desc = 'Kulala: Import Postman collection',
-- },
