return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  build = "make tiktoken",
  event = "VeryLazy",
  keys = {
    {
      "<leader>aw",
      function()
        require("CopilotChat").toggle()
      end,
      desc = "Copilot Chat Window",
    },
    {
      "<leader>ap",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.snacks").pick(actions.prompt_actions())
      end,
      desc = "CopilotChat - Prompt actions",
    },
    {
      "<leader>ar",
      function()
        require("CopilotChat").reset()
      end,
      desc = "Copilot Float Chat Window",
    },
    {
      "<leader>aq",
      function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          require("CopilotChat").ask(input)
        end
      end,
      desc = "Quick Chat (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>ae",
      function()
        require("CopilotChat").edit_last_message()
      end,
      desc = "Edit Last Message",
    },
    {
      "<leader>ah",
      function()
        require("CopilotChat").history()
      end,
      desc = "Chat History",
    },
  },
  opts = {
    mappings = {
      complete = {
        insert = "<Tab>",
      },
      close = {
        normal = "q",
        insert = "<leader>ax",
      },
      reset = {
        normal = "<leader>ar",
        insert = "<leader>ar",
      },
      submit_prompt = {
        normal = "<leader>as",
        insert = "<C-s>",
      },
      ["<C-l>"] = {
        normal = false,
        insert = false,
      },
    },
    question_header = "  User ",
    answer_header = "  Copilot ",
  },
}
