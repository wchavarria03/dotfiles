local M = {}

M.plugins = {
    {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter',
        checkout = 'main',
    },
}

function M.setup()
    vim.cmd.packadd 'nvim-treesitter'

    local parsers = {
        'bash',
        'beancount',
        'cairo',
        'css',
        'csv',
        'diff',
        'dockerfile',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'go',
        'gomod',
        'gosum',
        'gotmpl',
        'gowork',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'json5',
        'lua',
        'luadoc',
        'luap',
        'make',
        'markdown',
        'markdown_inline',
        'nginx',
        'ninja',
        'printf',
        'python',
        'query',
        'regex',
        'rst',
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

    vim.schedule(function()
        for _, parser in ipairs(parsers) do
            if not vim.treesitter.language.get_lang(parser) then
                vim.cmd('TSInstall ' .. parser)
            end
        end
    end)

    vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        callback = function()
            pcall(vim.treesitter.start)
        end,
    })

    vim.keymap.set('n', '<C-space>', function()
        vim.cmd 'normal! v'
        require('nvim-treesitter.incremental_selection').node_incremental()
    end, { desc = 'Init treesitter selection' })

    vim.keymap.set('v', '<C-space>', function()
        require('nvim-treesitter.incremental_selection').node_incremental()
    end, { desc = 'Increment treesitter selection' })

    vim.keymap.set('v', '<bs>', function()
        require('nvim-treesitter.incremental_selection').node_decremental()
    end, { desc = 'Decrement treesitter selection' })
end

return M
