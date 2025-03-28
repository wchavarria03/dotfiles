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
        go = { "golines", "goimports-reviser", "gofumpt" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        json = { "biome", "prettier" },
        lua = { "stylua" },
        ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        ruby = { "rubocop" },
        python = { "isort", "black" },
        sh = { "shfmt" },
        typescript = { "prettierd", "prettier", stop_after_first = true },
      },
      formatters = {
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then
                return true
              end
            end
          end,
        },
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
      },
    }
    return opts
  end,
}
