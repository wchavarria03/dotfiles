
-----------------------------------------------------------
-- Improve Loading TImes
-----------------------------------------------------------
vim.loader.enable()


-----------------------------------------------------------
-- NVIM Tree (Disable netrw)
-----------------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-----------------------------------------------------------
-- Import Lua modules
-----------------------------------------------------------

require('plugins/packer')             -- plugin manager
require('settings')                   -- settings
require('keymaps')                    -- keymaps
require('plugins/nvim-tree')	        -- file manager
require('plugins/onenord')            -- colorschema
require('plugins/lualine')            -- statusline
-- require('plugins/vscode')             -- colorschema
require('plugins/nvim-treesitter')    -- syntax highlight
require('plugins/nvim-telescope')     -- fuzzy finder
require('plugins/nvim-notify')        -- nice notification : Testing this one
require('plugins/gitsigns')           -- git visual help
-- require('plugins/nvim-autopairs')  -- autopairs
-- require('plugins/nvim-lsp-installer') -- LSP settings
require('plugins/mason') -- LSP settings
require('plugins/nvim-cmp')           -- autocomplete
-- require('plugins/wilder')             -- nice wildmenu

-- OTHER POSSIBILITIES
-- https://github.com/tpope/vim-dispatch
-- /nvim-dap
