local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ','
vim.g.maplocalleader = ' '

-- Build plugin spec based on mode
local plugin_spec = {
    -- import your plugins
    { import = 'plugins/ai' },
    { import = 'plugins/coding' },
    { import = 'plugins/editor' },
    { import = 'plugins/formatting' },
    { import = 'plugins/languages' },
    { import = 'plugins/linting' },
    { import = 'plugins/lsp' },
    { import = 'plugins/snacks' },
    { import = 'plugins/treesitter' },
    { import = 'plugins/ui' },
    { import = 'plugins/util' },
    { import = 'plugins' },
}

-- Add notes-specific plugins when in notes mode
if vim.g.nvim_mode == 'notes' then
    table.insert(plugin_spec, { import = 'plugins/notes' })
end

require('lazy').setup {
    spec = plugin_spec,
    -- dev = { "~/work", "~/personal" },
    rocks = {
        enabled = false,
    },
    checker = {
        enabled = true,
        notify = false, -- don't show update notifications
        frequency = 604800, -- check for updates once a week
    },
    change_detection = {
        enabled = true,
        notify = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip', -- Handles reading/writing of .gz files directly in Neovim.
                'netrwPlugin', -- Core plugin that enables the Netrw file browser
                'netrwSettings', -- Netrw config and handlers
                'netrwFileHandlers', -- Netrw config and handlers
                'rplugin', -- Loads remote plugins defined in rplugin.vim (typically used by Vimscript remote plugins or older RPC plugins
                'tarPlugin', -- Handles tar file editing via :e tarfile://
                'tohtml', -- Converts the current buffer to HTML
                'tutor', -- Tutor plugin for Vim
                'zipPlugin', -- Handles zip file editing via :e zipfile://
                'matchit', -- Extends % to match if/else, for/end, etc -- Replaced by nvim-treesitter-textobjects
                'logiPat', -- Legacy regex pattern support (used with matchit)
                'spellfile', -- Spell file support - Loads custom spellfiles

                -- 'matchparen', -- Highlight matching parentheses
            },
        },
        cache = {
            enabled = true,
            path = vim.fn.stdpath 'cache' .. '/lazy/cache',
            -- After one hour, Neovim will clean up the cache directory
            ttl = 60 * 60 * 24, -- 1 day
        },
    },
    ui = {
        border = 'rounded',
        icons = {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🔑',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
}
