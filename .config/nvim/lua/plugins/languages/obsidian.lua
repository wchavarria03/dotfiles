local M = {}

M.plugins = {
    'https://github.com/epwalsh/obsidian.nvim',
}

function M.setup()
    require('obsidian').setup {
        workspaces = {
            {
                name = 'personal',
                path = '~/personal/notes',
            },
        },
        daily_notes = {
            folder = '0-Inbox',
            date_format = '%Y-%m-%d',
        },
        new_notes_location = 'notes_subdir',
        notes_subdir = '0-Inbox',
        attachments = {
            img_folder = 'attachments',
        },
        picker = {
            name = 'snacks.picker',
        },
        ui = {
            enable = false,
        },
        completion = {
            nvim_cmp = false,
        },
    }

    vim.keymap.set('n', 'gf', function()
        if require('obsidian').util.cursor_on_markdown_link() then
            return '<cmd>ObsidianFollowLink<cr>'
        else
            return 'gf'
        end
    end, { noremap = false, expr = true, desc = 'Follow link or gf' })

    vim.keymap.set('n', '<leader>nd', '<cmd>ObsidianToday<cr>', { desc = 'Daily note (today)' })
    vim.keymap.set('n', '<leader>nn', '<cmd>ObsidianNew<cr>', { desc = 'New note' })
    vim.keymap.set('n', '<leader>nf', '<cmd>ObsidianSearch<cr>', { desc = 'Search notes' })
    vim.keymap.set('n', '<leader>nw', '<cmd>ObsidianQuickSwitch<cr>', { desc = 'Quick switch note' })
    vim.keymap.set('n', '<leader>np', '<cmd>ObsidianPasteImg<cr>', { desc = 'Paste image' })
end

return M
