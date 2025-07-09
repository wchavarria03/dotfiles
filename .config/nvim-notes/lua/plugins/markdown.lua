return {
  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  -- Table mode for easy table creation in markdown
  {
    "dhruvasagar/vim-table-mode",
    ft = "markdown",
  },

  -- Auto-generate table of contents
  {
    "mzlogin/vim-markdown-toc",
    ft = "markdown",
  },
} 