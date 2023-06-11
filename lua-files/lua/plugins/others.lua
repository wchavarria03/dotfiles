return {
 {
    'iamcco/markdown-preview.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    enabled = false,
    ft = {'markdown'},
    build = 'cd app && npm install',
    config = function()
        vim.g.mkdp_filetypes = { 'markdown' }
    end,
  }
}
