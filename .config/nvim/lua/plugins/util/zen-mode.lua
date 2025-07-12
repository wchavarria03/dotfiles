return {
  "folke/zen-mode.nvim",
  event = "VeryLazy",
  opts = function()
    local is_notes_mode = vim.g.nvim_mode == "notes"
    
    if is_notes_mode then
      -- Notes mode: Enhanced zen configuration for focused writing
      return {
        window = {
          width = 120,
          options = {
            number = false,
            relativenumber = false,
            signcolumn = "no",
            foldcolumn = "0",
            list = false,
          },
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false,
            showcmd = false,
            laststatus = 0,
          },
          twilight = { enabled = true },
        },
      }
    else
      -- Full mode: Basic zen configuration
      return {}
    end
  end,
}
