return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = { "InsertEnter", "LspAttach" },
  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = true,
      auto_trigger = false,
      debounce = 150,
      keymap = {
        accept = "<C-l>",
        accept_word = false,
        accept_line = false,
        next = "<C-]>",
        prev = "<C-[>",
        dismiss = "<C-]>",
      },
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
    server_opts_overrides = {
      trace = "verbose",
      settings = {
        advanced = {
          listCount = 10,
          inlineSuggestCount = 3,
        },
      },
    },
  },
}
