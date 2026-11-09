local M = {}

M.plugins = {
    'https://github.com/obsidian-nvim/obsidian.nvim',
}

function M.setup()
    require('obsidian').setup {
        legacy_commands = false,
        workspaces = {
            { name = 'personal', path = '~/personal/notes' },
        },
        notes_subdir = 'second-brain',
        templates = {
            folder = 'templates',
        },
        completion = {
            blink = true,
            nvim_cmp = false,
        },
    }
end

return M
