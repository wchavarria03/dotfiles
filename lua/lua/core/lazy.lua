vim.g.mapleader = ',' -- change leader to a comma
vim.g.maplocalleader = ';' -- change local leader to a commacorelua
vim.opt.timeoutlen = 300 -- time waiting for key after leader key
-----------------------------------------------------------
-- NVIM Tree (Disable netrw)
-----------------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-----------------------------------------------------------
-- Improve Loading TImes
-----------------------------------------------------------
vim.loader.enable()

require 'core/options' -- options
require 'core/commands' -- commands
require 'core/keymaps' -- keymaps
-----------------------------------------------------------
-- Import Lua modules
-----------------------------------------------------------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
--
-----------------------------------------------------------
local opts = {
  spec = { import = 'plugins' },
  ui = {
    border = 'single',
    icons = {
      ft = '',
      loaded = '',
      not_loaded = '',
      config = '',
      init = ' ',
      keys = ' ',
      plugin = ' ',
      runtime = ' ',
      source = ' ',
      task = ' ',
    },
  },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    notify = true, -- get a notification when new updates are found
    frequency = 28800, -- check for updates every 8 hours
  },

  install = { colorscheme = { 'catppuccin-mocha' } },
  change_detection = {
    notify = false,
  },
  performance = {
    cache = {
      path = vim.fn.stdpath 'state' .. '/lazy/cache',
      -- Once one of the following events triggers, caching will be disabled.
      -- To cache all modules, set this to `{}`, but that is not recommended.
      -- The default is to disable on:
      --  * VimEnter: not useful to cache anything else beyond startup
      --  * BufReadPre: this will be triggered early when opening a file from the command line directly
      disable_events = { 'UIEnter', 'VimEnter', 'BufReadPre' },
    },
    reset_packpath = true,
    rtp = {
      reset = false, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        -- 'tutor',
        'zipPlugin',
      },
    },
  },
}

local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
  return
end

lazy.setup('plugins', opts)
