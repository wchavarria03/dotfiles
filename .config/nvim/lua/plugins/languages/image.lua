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
                filetypes = { 'markdown', 'obsidian' },
                resolve_image_path = function(document_path, image_path, fallback)
                    local vault = vim.fn.expand '~/personal/notes'
                    local attachment = vault .. '/attachments/' .. image_path
                    if vim.fn.filereadable(attachment) == 1 then
                        return attachment
                    end
                    return fallback(document_path, image_path)
                end,
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
