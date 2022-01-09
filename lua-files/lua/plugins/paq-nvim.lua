-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: paq-nvim
-- https://github.com/savq/paq-nvim

vim.cmd 'packadd paq-nvim'            -- load paq
local paq = require('paq-nvim').paq   -- import module with `paq` function

-- Add packages
-- for package info see: init.lua (Lua modules)
require('paq') {
  'savq/paq-nvim';                  -- let paq manage itself
  'famiu/feline.nvim';

  -- Color Schema
  'glepnir/zephyr-nvim';
--  'EdenEast/nightfox.nvim';

  'kyazdani42/nvim-web-devicons';
--  'kyazdani42/nvim-tree.lua';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';

--  'Yggdroot/indentLine';
--  'liuchengxu/vista.vim';
  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'};
--   'neovim/nvim-lspconfig';
--  'hrsh7th/nvim-cmp';
--  'hrsh7th/cmp-nvim-lsp';
--  'hrsh7th/cmp-path';
--  'hrsh7th/cm-buffer';
--  'saadparwaiz1/cmp_luasnip';
--  'L3MON4D3/LuaSnip';
--  'windwp/nvim-autopairs';
--  'tanvirtin/monokai.nvim';
}

-- local fn = vim.fn

-- local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

-- if fn.empty(fn.glob(install_path)) > 0 then
--   fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
-- end
