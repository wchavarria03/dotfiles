-- Set leader key
vim.g.mapleader = ','

-- Load core configuration
require 'core.options'
require 'core.keymaps'
require 'core.autocommands'

-- General
require 'plugins.colorscheme'
require 'plugins.snacks'

-- Editor
require 'plugins.editor.setup'

-- LSP
require 'plugins.lsp.setup'

-- AI
require 'plugins.ai.setup'

-- Coding
require 'plugins.coding.setup'

-- Linting
require 'plugins.linting.setup'

-- Formating
require 'plugins.formatting.conform-nvim'

-- UI
require 'plugins.ui.lualine'

-- Treesitter
require 'plugins.treesitter.treesitter'

-- Utils
require 'plugins.utils.setup'
pcall(require, 'undotree')

-- Languages
require 'plugins.languages.setup'

require 'core.lsp'
