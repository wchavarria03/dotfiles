-----------------------------------------------------------
-- Improve Loading TImes
-----------------------------------------------------------
vim.loader.enable()


-----------------------------------------------------------
-- NVIM Tree (Disable netrw)
-----------------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('settings')                   -- settings
require('keymaps')                    -- keymaps

-----------------------------------------------------------
-- Import Lua modules
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
--
-----------------------------------------------------------
return require('lazy').setup({
  spec = { import = "plugins" },
  --[[
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = true,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  ui = {
    border = "single",
  },
  diff = { cmd = 'diffview.nvim'},
  ]]--
})

-- OTHER POSSIBILITIES
-- https://github.com/tpope/vim-dispatch
-- /nvim-dap
