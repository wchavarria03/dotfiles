return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  opts = {
    suggestion = {
      enabled = true,
    },
    panel = {
      enabled = false,
    },
    filetypes = {
      markdown = true,
      help = true,
    },
    copilot_model = "gpt-4o-copilot",
    panel_width = 40,
  },
  config = function(_, opts)
    require("copilot").setup(opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuOpen",
      callback = function()
        vim.b.copilot_suggestion_hidden = true
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuClose",
      callback = function()
        vim.b.copilot_suggestion_hidden = false
      end,
    })
  end,
}
