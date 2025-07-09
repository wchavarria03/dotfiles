-- Neovim configuration for notes
-- This config uses NVIM_APPNAME=notes for separate configuration

-- Set runtime path for NVIM_APPNAME
vim.opt.runtimepath:prepend(vim.fn.stdpath("config"))

-- Load configuration modules
require('options')
require('plugins')  -- Load plugins first (includes lazy.nvim bootstrap)
require('keymaps')
require('autocmds')
