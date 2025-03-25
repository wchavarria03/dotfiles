return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "single",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      -- mason-lspconfig doesn't not install linters, formatters nor any other tools besides the language servers.
      -- This is the list of them that were manually installed.

      -- Linters
      ---- Bash
      -------- shellcheck
      ---- Docker
      -------- hadolint
      ---- Go
      -------- golangcilint - JSON
      -------- Biome
      ---- Lua
      -------- TODO: Fix this linter which is failing to install on mason
      -------- luacheck
      ---- Python
      -------- flake8
      ---- Typscript
      ------- eslint_d
      ---- General coding spell
      -------- codespell
      -------- cspell
      ---- Github
      -------- commitlint

      -- Formatters
      ---- Python
      -------- black
      -------- isort
      ---- Go
      -------- gofumpt
      -------- goimports-reviser
      -------- golines
      ---- JSON
      -------- biome
      ---- Lua
      -------- stylua
      ---- Markdown / Javascript / json
      -------- prettier
      ---- Shell
      -------- shfmt

      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Bash
          "bashls",

          -- BeanCount
          "beancount",

          -- Docker
          "dockerls",
          "docker_compose_language_service",

          -- Go
          "gopls",

          -- JSON
          "jsonls",

          -- Lua
          "lua_ls",

          -- Markdown
          "marksman",

          -- Python
          "pyright",

          -- Python
          "ruby_lsp",
          -- TypeScript / Javascript
          "ts_ls",
        },
        automatic_installation = false,
      })
    end,
  },
}
