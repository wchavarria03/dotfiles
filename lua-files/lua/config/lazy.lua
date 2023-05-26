-----------------------------------------------------------
-- Improve Loading TImes
-----------------------------------------------------------
vim.loader.enable()


-----------------------------------------------------------
-- NVIM Tree (Disable netrw)
-----------------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('config/settings')                   -- settings
require('config/highlights')                 -- highlights
require('config/keymaps')                    -- keymaps

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
  ui = {
    border = "single",
  },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    notify = true, -- get a notification when new updates are found
    frequency = 28800, -- check for updates every 8 hours
  },
  install = { colorscheme = { 'catppuccin' } },
  -- diff = { cmd = 'diffview.nvim'},
})

-- OTHER POSSIBILITIES
-- https://github.com/tpope/vim-dispatch
-- /nvim-dap
