-- Set the mode: "full" for development, "notes" for note-taking
-- Can be set via environment variable NVIM_MODE or defaults to "full"
-- vim.g.nvim_mode = vim.env.NVIM_MODE or "full"

-- Set the mode: "full" for development, "notes" for note-taking
-- Can be set via environment variable NVIM_MODE or defaults to "full"
vim.g.nvim_mode = vim.env.NVIM_MODE or "full"

-- Set leader key
vim.g.mapleader = ','

-- Load core configuration
require 'core.options'
require 'core.keymaps'
require 'core.autocommands'

-- Load mode-specific config
if vim.g.nvim_mode == 'notes' then
    require 'modes.notes'
end

require 'core.lazy'
require 'core.lsp'
