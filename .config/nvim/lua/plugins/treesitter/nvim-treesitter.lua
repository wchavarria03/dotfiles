return {
    'nvim-treesitter/nvim-treesitter',
    version = false, -- last release is way too old and doesn't work on Windows
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    init = function(plugin)
        require('lazy.core.loader').add_to_rtp(plugin)
        require 'nvim-treesitter.query_predicates'
    end,
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    keys = {
        { '<c-space>', desc = 'Increment Selection' },
        { '<bs>', desc = 'Decrement Selection', mode = 'x' },
    },
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
            'bash',

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
        sync_install = false,
        auto_install = true,
        ignore_install = {},
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
}
