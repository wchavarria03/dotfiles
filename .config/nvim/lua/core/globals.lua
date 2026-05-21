-- Set leader key
vim.g.mapleader = ','

-- Luarocks path (required for image.nvim magick dependency)
package.path = package.path
    .. ';'
    .. vim.fn.expand '$HOME'
    .. '/.luarocks/share/lua/5.1/?.lua'
    .. ';'
    .. vim.fn.expand '$HOME'
    .. '/.luarocks/share/lua/5.1/?/init.lua'
package.cpath = package.cpath .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/lib/lua/5.1/?.so'

vim.g.experimental_ui2 = false

vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
