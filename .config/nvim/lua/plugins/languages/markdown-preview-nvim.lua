vim.pack.add {
    'https://github.com/selimacerbas/live-server.nvim',
    'https://github.com/selimacerbas/markdown-preview.nvim',
}

require('markdown_preview').setup {
    mkit = {},
    katex = {},
    uml = {},
    maid = {
        -- This enables interactive zooming/panning in the browser
        theme = 'forest',
        mermaid = {
            startOnLoad = true,
            -- Ensure interactive diagrams are enabled
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
