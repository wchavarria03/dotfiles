return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    flavour = "mocha",
    integrations = {
      blink_cmp = true,
      bufferline = true,
      copilot_vim = true,
      flash = true,
      fzf = true,
      gitsigns = true,
      harpoon = true,
      mason = true,
      mini = {
        enabled = true,
        indentscope_color = "lavender",
      },
      neotree = true,
      noice = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
          ok = { "underline" },
        },
        inlay_hints = {
          background = true,
        },
      },
      treesitter = true,
      render_markdown = true,
      snacks = true,
      which_key = true,
    },
    dim_inactive = {
      enabled = true,
      percentage = 0.60,
      shade = "light",
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
