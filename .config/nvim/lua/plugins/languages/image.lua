local M = {}

M.plugins = {
    'https://github.com/3rd/image.nvim',
}

function M.setup()
    require('image').setup {
        backend = 'kitty',
        integrations = {
            markdown = {
                enabled = true,
                filetypes = { 'markdown' },
            },
        },
        max_width = 80,
        max_height = 20,
        max_width_window_percentage = 60,
        max_height_window_percentage = 40,
        hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.svg' },
    }
end

return M
