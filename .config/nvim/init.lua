-- Set the mode: "full" for development, "notes" for note-taking
-- Can be set via environment variable NVIM_MODE or defaults to "full"
-- vim.g.nvim_mode = vim.env.NVIM_MODE or "full"

-- Load shared config
require 'config.options'
require 'config.keymaps'
require 'config.autocommands'

-- Load mode-specific config
-- if vim.g.nvim_mode == "notes" then
--     require 'config.notes-mode'
-- end

require 'core.lazy'
require 'core.lsp'

