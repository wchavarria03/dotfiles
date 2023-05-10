local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- System icons
  use 'nvim-tree/nvim-web-devicons'

  -- Status Line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- Color Schema
  use 'rmehri01/onenord.nvim'

  -- LSP Servers
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  -- Completition
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'f3fora/cmp-spell',
      'ray-x/cmp-treesitter',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp-document-symbol'
    }
  }

  -- Code Syntax highlight
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Fuzzy Finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Notifications
  use "rcarriga/nvim-notify"

  -- Directory Tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons'
  }

  --  Git info on nvim
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  -- Nice Wildmenu
  use 'gelguy/wilder.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
