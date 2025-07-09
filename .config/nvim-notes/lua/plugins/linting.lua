return {
  -- Linting for markdown files
  {
    'mfussenegger/nvim-lint',
    event = 'VeryLazy',
    dependencies = {
      'rshkarin/mason-nvim-lint',
    },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint', 'cspell', 'codespell' },
        text = { 'cspell', 'codespell' },
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
        ['_'] = { 'cspell', 'codespell' }, -- fallback
      }
    end,
  },
} 