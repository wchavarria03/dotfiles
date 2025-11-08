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
        checkout = 'main',
    },
}

-- Load the plugin immediately
vim.cmd 'packadd nvim-treesitter'

-- ----------------------------------------------------------------------------
-- Plugin Setup
-- ----------------------------------------------------------------------------

-- The main branch has a simpler API - just install parsers
local parsers_to_install = {
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
}

-- Install parsers using TSInstall command
-- The main branch uses a simpler API - parsers are installed via commands
vim.schedule(function()
    for _, parser in ipairs(parsers_to_install) do
        if not vim.treesitter.language.get_lang(parser) then
            vim.cmd('TSInstall ' .. parser)
        end
    end
end)

-- Enable treesitter highlighting for all filetypes
vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

-- Enable incremental selection keymaps
vim.keymap.set('n', '<C-space>', function()
    vim.cmd('normal! v')
    require('nvim-treesitter.incremental_selection').node_incremental()
end, { desc = 'Init treesitter selection' })

vim.keymap.set('v', '<C-space>', function()
    require('nvim-treesitter.incremental_selection').node_incremental()
end, { desc = 'Increment treesitter selection' })

vim.keymap.set('v', '<bs>', function()
    require('nvim-treesitter.incremental_selection').node_decremental()
end, { desc = 'Decrement treesitter selection' })
