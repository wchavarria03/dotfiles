return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    local opts = {
      options = {
        theme = "auto",
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          { "filename" },
        },
        lualine_x = {
          {
            function()
              local clients = package.loaded["copilot"] and vim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}
              if #clients > 0 then
                local status = require("copilot.api").status.data.status
                return (status == "InProgress" and "... ") or (status == "Warning" and "X ") or ""
              end
            end,
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
        },
        lualine_z = {
          { "location", padding = { left = 0, right = 1 } },
        },
      },
      extensions = { "neo-tree", "lazy", "trouble", "fugitive" },
    }

    return opts
  end,
}
