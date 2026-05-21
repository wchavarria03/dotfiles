local M = {}

M.plugins = {
    'https://github.com/mistweaverco/kulala.nvim',
}

function M.setup()
    require('kulala').setup {
        ui = {
            display_mode = 'split',
        },
        global_keymaps_prefix = '<leader>k',
    }

    vim.filetype.add {
        extension = {
            ['http'] = 'http',
        },
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>kr', function()
        require('kulala').run()
    end, { desc = 'Kulala: Run request' })

    vim.keymap.set({ 'n', 'v' }, '<leader>kc', function()
        require('kulala').copy()
    end, { desc = 'Kulala: Copy as cURL' })

    vim.keymap.set({ 'n', 'v' }, '<leader>ke', function()
        require('kulala').set_selected_env()
    end, { desc = 'Kulala: Select environment' })

    vim.keymap.set({ 'n', 'v' }, '<leader>kn', function()
        require('kulala').jump_next()
    end, { desc = 'Kulala: Jump to next request' })

    vim.keymap.set({ 'n', 'v' }, '<leader>kp', function()
        require('kulala').jump_prev()
    end, { desc = 'Kulala: Jump to previous request' })

    vim.keymap.set({ 'n', 'v' }, '<leader>kf', function()
        require('kulala').search()
    end, { desc = 'Kulala: Find request' })

    vim.keymap.set({ 'n', 'v' }, '<leader>kj', function()
        require('kulala').open_cookies_jar()
    end, { desc = 'Kulala: Open cookies jar' })

    vim.keymap.set({ 'n', 'v' }, '<leader>kcg', function()
        require('kulala').scripts_clear_global()
    end, { desc = 'Kulala: Clear global variables' })

    vim.keymap.set({ 'n', 'v' }, '<leader>kcf', function()
        require('kulala').clear_cached_files()
    end, { desc = 'Kulala: Clear cached files' })
end

return M
