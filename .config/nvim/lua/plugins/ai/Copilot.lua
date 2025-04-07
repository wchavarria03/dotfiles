return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = { "InsertEnter", "LspAttach" },
  opts = {
    panel = {
      enabled = false,
    },
    suggestion = { -- blink-cmp-copilot would be in charge of this
      enabled = false,
    },
    filetypes = {
      yaml = true,
      markdown = true,
      help = true,
      gitcommit = true,
      gitrebase = true,
      ["."] = false,
    },
    copilot_model = "gpt-4o-copilot",
  },
}
