return {
  "neovim/nvim-lspconfig",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = true,
      float = {
        header = false,
        border = "rounded",
        focusable = true,
      },
    },
    inlay_hints = {
      enabled = true,
    },
  },
  config = function(_, opts)
    -- Add rounded borders to the hover window
    vim.diagnostic.config(opts.diagnostics)

    -- SERVERS
    local servers = {
      "pyright",
      "ruby_lsp",
    }
  end,
}
