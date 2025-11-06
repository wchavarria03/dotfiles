-- ============================================================================
-- nvim-treesitter Configuration
-- ============================================================================
-- Treesitter provides better syntax highlighting and code understanding

-- ----------------------------------------------------------------------------
-- Auto-update Hook
-- ----------------------------------------------------------------------------

vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('TreesitterUpdate', { clear = true }),
    callback = function(event)
        local plugin_name = event.data.spec.source:match '/([^/]+)$'
        local action = event.data.kind

        if plugin_name == 'nvim-treesitter' and (action == 'install' or action == 'update') then
            vim.notify('Updating treesitter parsers...', vim.log.levels.INFO)
            vim.cmd 'TSUpdate'
        end
    end,
})

-- ----------------------------------------------------------------------------
-- Plugin Installation
-- ----------------------------------------------------------------------------

vim.pack.add {
    {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    },
}

-- Load the plugin immediately
vim.cmd 'packadd nvim-treesitter'

-- ----------------------------------------------------------------------------
-- Plugin Setup
-- ----------------------------------------------------------------------------

require('nvim-treesitter.configs').setup {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
        'bash',
        'beancount',

        'diff',
        'css',
        'csv',
        'dockerfile',

        -- Git
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',

        -- Go
        'go',
        'gomod',
        'gosum',
        'gotmpl',
        'gowork',

        --JSON
        'json5',

        -- Python
        'ninja',
        'rst',

        'cairo',
        'html',
        'javascript',
        'jsdoc',
        'jsonc',
        'lua',
        'luadoc',
        'luap',
        'make',
        'markdown',
        'markdown_inline',
        'nginx',
        'printf',
        'python',
        'query',
        'regex',
        'scss',
        'solidity',
        'terraform',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = false,
            node_decremental = '<bs>',
        },
    },
    -- Performance optimizations
    sync_install = true,
    auto_install = true,
    ignore_install = {},
}
