local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- System icons
  use 'kyazdani42/nvim-web-devicons'

  -- Status Line
  use 'famiu/feline.nvim'

  -- Color Schema
  use 'Mofiqul/vscode.nvim'

  -- Code Syntax highlight
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    'neovim/nvim-lspconfig',
    event = { 'BufRead' },
    after = 'nvim-treesitter'
  }

  -- Fuzzy Finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

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

end)
