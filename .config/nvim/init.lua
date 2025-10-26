-- Set leader key
vim.g.mapleader = ','

-- Load core configuration
require 'core.options'
require 'core.keymaps'
require 'core.autocommands'

-- General
require 'plugins.colorscheme'
require 'plugins.snacks'

-- Core Utils (must load early, used by other plugins)
require 'plugins.utils.plenary'
require 'plugins.utils.nvim-web-devicons'

-- Treesitter (must load before editor plugins and languages)
require 'plugins.treesitter.treesitter'

-- Editor
require 'plugins.editor.setup'

-- Coding (blink.cmp must load before LSP for capabilities)
require 'plugins.coding.setup'

-- LSP (depends on blink.cmp capabilities)
require 'plugins.lsp.setup'

-- AI
require 'plugins.ai.setup'

-- Linting
require 'plugins.linting.setup'

-- Formatting
require 'plugins.formatting.conform-nvim'

-- UI
require 'plugins.ui.lualine'

-- Additional Utils (non-core utilities)
require 'plugins.utils.kulala'
require 'plugins.utils.cloak'
require 'plugins.utils.smart-splits'
require 'plugins.utils.hardtime'
require 'plugins.utils.precognition'
require 'plugins.utils.undo-tree'
pcall(require, 'undotree')

-- Languages (render-markdown depends on treesitter)
require 'plugins.languages.setup'
