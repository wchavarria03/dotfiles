local function override_lsp()
  local lsp_error_override = { "yamlls" }
  local active_lsp = require("utils").clients_lsp()
  for _, client in ipairs(lsp_error_override) do
    if string.match(client, active_lsp) then
      return true
    end
  end
end

return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  cmd = "ConformInfo",
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
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
      -- format_on_save = function()
      -- local next = next
      --- check if we have to skip formatting due to lsp errors
      -- if next(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })) ~= nil and not override_lsp() then
      -- local clients = require("utils").clients_lsp()
      -- local icons = require("utils").icons
      -- require("Snacks").notifier.notify("WALTER")
      --
      -- require("Snacks").notifier.notify(
      --   "LSP errors, cannot format: "
      --     .. #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      --     .. icons.statusline.Error
      --     .. " "
      --     .. #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      --     .. icons.statusline.Warn,
      --   "warn",
      --   { title = clients, style = "compact", ft = "txt", id = "lsp_error" }
      -- )
      -- return
      -- end

      -- return { timeout_ms = 3000, lsp_fallback = true, lsp_format = "fallback" }
      -- end,
      format_on_save = { timeout_ms = 3000, lsp_fallback = true, lsp_format = "fallback" },

      formatters_by_ft = {
        bash = { "shfmt" },
        beancount = { "bean-format" },
        go = { "golines", "goimports", "gofumpt" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        json = { "biome", "prettier" },
        lua = { "stylua" },
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        ruby = { "rubocop" },
        python = { "isort", "black" },
        sh = { "shfmt" },
        typescript = { "prettierd", "prettier", stop_after_first = true },
      },
    }
    return opts
  end,
}
