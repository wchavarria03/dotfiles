local utils = require "core.utils"
local merge_tb = vim.tbl_deep_extend

return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "Notes",
          path = "/Users/wchavarria/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"
        }
      },
    },
    config = function(_, opts)
      require("obsidian").setup(opts)

      local localOpts = { noremap = true, silent = true, nowait = true }

      utils.mapKey('Obsidian', 'n', '<leader>fn', '<cmd>ObsidianQuickSwitch<CR>', merge_tb('force', localOpts, { desc = 'Find Notes' }));

      vim.keymap.set("n", "gd", function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<cmd>ObsidianFollowLink<CR>"
        else
          return "gd"
        end
      end, { noremap = false, expr = true })
    end,
  }
}
