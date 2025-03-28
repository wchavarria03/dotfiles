return {
  "olimorris/codecompanion.nvim",
  opts = {
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "claude-3.7-sonnet-thought",
            },
          },
        })
      end,
    },
    strategies = {
      adapter = "copilot",
      roles = {
        user = "Walter",
      },
      inline = { adapter = "copilot" },
    },
    opts = {
      log_level = "DEBUG",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
