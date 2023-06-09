return {
 {
    'iamcco/markdown-preview.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    run = function()
      vim.fn['mkdp#util#install']()
    end,
  }
}
