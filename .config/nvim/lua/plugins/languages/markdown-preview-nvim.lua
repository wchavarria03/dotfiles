local M = {}

M.plugins = {
    'https://github.com/selimacerbas/live-server.nvim',
    'https://github.com/selimacerbas/markdown-preview.nvim',
}

function M.setup()
    require('markdown_preview').setup {
        mkit = {},
        katex = {},
        uml = {},
        maid = {
            theme = 'forest',
            mermaid = {
                startOnLoad = true,
                securityLevel = 'loose',
            },
        },
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
    }

    vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreview<cr>', { desc = 'Markdown Preview' })
    vim.keymap.set('n', '<leader>ms', '<cmd>MarkdownPreviewStop<cr>', { desc = 'Markdown Preview Stop' })
end

return M
