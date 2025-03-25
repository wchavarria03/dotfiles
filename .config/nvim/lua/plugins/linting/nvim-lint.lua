return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      bash = { "shellcheck" },
      beancount = { "bean_check" },
      dockerfile = { "hadolint" },
      go = { "golangcilint" },
      javascript = { "eslint_d" },
      json = { "biome" },
      lua = { "luacheck" },
      markdown = { "markdownlint-cli2" },
      python = { "flake8" },
      typescript = { "eslint_d" },
      -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
      ["_"] = { "cspell", "codespell" },
    },
  },
  config = function()
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
