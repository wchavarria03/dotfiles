-- Set leader key
vim.g.mapleader = ','

-- Load core configuration
require 'core.options'
require 'core.keymaps'
require 'core.autocommands'

-- General
require 'plugins.colorscheme'

-- Editor
require 'plugins.editor.setup'

-- AI
require 'plugins.ai.setup'

require 'core.lsp'
