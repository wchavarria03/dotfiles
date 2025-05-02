local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","
vim.g.maplocalleader = " "

require("config/keymaps")
require("config/options")
require("config/autocommands")

require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins/ai" },
    { import = "plugins/coding" },
    { import = "plugins/editor" },
    { import = "plugins/formatting" },
    { import = "plugins/languages" },
    { import = "plugins/linting" },
    { import = "plugins/lsp" },
    { import = "plugins/snacks" },
    { import = "plugins/treesitter" },
    { import = "plugins/ui" },
    { import = "plugins/util" },
    { import = "plugins" },
  },
  checker = {
    enabled = true,
    notify = false, -- don't show update notifications
    frequency = 3600 * 24, -- check once per day
  },
  ui = {
    border = "rounded",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🔑",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
