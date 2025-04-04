return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    code = {
      sign = false,
      width = "block",
      right_pad = 1,
    },
    -- file_types = { "markdown", "codecompanion", "Avante" },
    file_types = { "markdown", "codecompanion" },
    completions = { blink = { enabled = true } },
    latex = { enabled = false },
  },
  ft = { "markdown", "norg", "rmd", "org", "Avante" },
  config = function(_, opts)
    require("render-markdown").setup(opts)
    require("snacks")
      .toggle({
        name = "Render Markdown",
        get = function()
          return require("render-markdown.state").enabled
        end,
        set = function(enabled)
          local m = require("render-markdown")
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      })
      :map("<leader>tm")
  end,
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
}
