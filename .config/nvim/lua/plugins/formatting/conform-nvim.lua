return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  cmd = "ConformInfo",
  dependencies = {
    "zapling/mason-conform.nvim",
  },
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
  opts = function()
    local opts = {
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = function(bufnr)
        if vim.g.autoformat then
          local disable_filetypes = {}
          local lsp_format_opt
          if disable_filetypes[vim.bo[bufnr].filetype] then
            lsp_format_opt = "never"
          else
            lsp_format_opt = "fallback"
          end
          return {
            timeout_ms = 3000,
            lsp_format = lsp_format_opt,
          }
        else
          return
        end
      end,

      formatters_by_ft = {
        bash = { "shfmt" },
        beancount = { "bean-format" },
        go = { "golines", "goimports", "gofumpt", "golangci-lint" },
        json = { "biome", "prettier" },
        lua = { "stylua" },
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        ruby = { "rubocop" },
        python = { "isort", "black" },
        sh = { "shfmt" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      },
    }
    return opts
  end,
}
