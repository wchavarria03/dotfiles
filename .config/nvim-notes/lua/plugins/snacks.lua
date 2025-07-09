return {
  -- Snacks picker (reuse from regular config)
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      picker = {
        matcher = {
          frecency = true,
        },
        sources = {
          files = { hidden = true },
        },
      },
    },
    keys = {
      -- File finding
      { "<leader>ff", function() require("snacks").picker.smart() end, desc = "Find Files Smart" },
      { "<leader>fb", function() require("snacks").picker.buffers() end, desc = "Buffers" },
      { "<leader>fr", function() require("snacks").picker.recent() end, desc = "Recent" },
      
      -- Search within notes
      { "<leader>sw", function() require("snacks").picker.grep_word() end, desc = "Search word", mode = { "n", "x" } },
      { "<leader>sb", function() require("snacks").picker.lines() end, desc = "Search buffer lines" },
      { "<leader>s/", function() require("snacks").picker.grep({ hidden = true }) end, desc = "Grep in notes" },
    },
  },
} 