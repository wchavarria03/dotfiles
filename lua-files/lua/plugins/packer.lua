local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- System icons
  use 'kyazdani42/nvim-web-devicons'

  -- Status Line
  use 'famiu/feline.nvim'

  -- Color Schema
  use 'Mofiqul/vscode.nvim'

  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer'
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
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Notifications
  use "rcarriga/nvim-notify"

  -- Directory Tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  --  Git info on nvim
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  -- Improve Lua files loading time by using cache files
  use 'lewis6991/impatient.nvim'

  -- Nice Wildmenu
  use 'gelguy/wilder.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
