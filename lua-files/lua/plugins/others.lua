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
  },
  {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    enabled = false,
    opts = {
      restricted_keys = {
        ["h"] = { "n", "v" },
        ["j"] = { "n", "v" },
        ["k"] = { "n", "v" },
        ["l"] = { "n", "v" },
        ["-"] = { "n", "v" },
        ["+"] = { "n", "v" },
        ["gj"] = { "n", "v" },
        ["gk"] = { "n", "v" },
        ["<CR>"] = { "n", "v" },
        ["<C-M>"] = { "n", "v" },
        ["<C-N>"] = { "n", "v" },
      },
    }
  },
}
