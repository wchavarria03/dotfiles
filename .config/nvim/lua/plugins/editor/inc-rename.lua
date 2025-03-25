return {
  "smjonas/inc-rename.nvim",
  event = "VeryLazy",
  config = function(_, opts)
    require("inc_rename").setup(opts)
    vim.keymap.set("n", "<leader>cr", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true, desc = "Rename symbol under cursor" })
  end,
}
