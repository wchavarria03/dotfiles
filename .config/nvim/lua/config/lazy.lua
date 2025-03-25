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
  -- install = { colorscheme = { "catppuccin" } },
  -- install = { colorscheme = { "tokyonight" } },
  --vim.cmd[[colorscheme tokyonight]]
  -- check for plugin updates periodically
  checker = {
    enabled = true,
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
  },
})
