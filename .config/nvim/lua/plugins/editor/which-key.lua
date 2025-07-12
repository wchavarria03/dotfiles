return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        preset = 'helix',
        plugins = { spelling = true },
        defaults = {},
        spec = {
            {
                mode = { 'n', 'v' },
                { '<leader>a', group = 'ai' },
                {
                    '<leader>b',
                    group = 'buffer',
                    expand = function()
                        return require('which-key.extras').expand.buf()
                    end,
                },
                { '<leader>c', group = 'code' },
                { '<leader>f', group = 'find/file' },
                { '<leader>g', group = 'git' },
                { '<leader>gh', group = 'hunks' },
                { '<leader>i', group = 'image' },
                { '<leader>l', group = 'lsp' },
                { '<leader>m', group = 'markdown' },
                { '<leader>n', group = 'notes' },
                { '<leader>nt', group = 'todos', icon = { icon = '󰅚', color = 'red' } },
                { '<leader>q', group = 'quit/session' },
                { '<leader>r', group = 'restart' },
                { '<leader>s', group = 'search' },
                { '<leader>t', group = 'toggle' },
                { '<leader>tg', group = 'git', icon = { icon = '󰙵 ', color = 'cyan' } },
                { '<leader>u', group = 'ui', icon = { icon = '󰙵 ', color = 'cyan' } },
                {
                    '<leader>w',
                    group = 'windows',
                    proxy = '<c-w>',
                    expand = function()
                        return require('which-key.extras').expand.win()
                    end,
                },
                { '<leader>x', group = 'iagnostics/quickfix', icon = { icon = '󱖫 ', color = 'green' } },
                { '[', group = 'prev' },
                { ']', group = 'next' },
                { 'g', group = 'goto' },
                { 'gs', group = 'surround' },
                { 'gx', desc = 'Open with system app' },
                { 'z', group = 'fold' },
            },
        },
    },
    keys = {
        {
            '<leader>?',
            function()
                require('which-key').show { global = false }
            end,
            desc = 'Buffer Local Keymaps (which-key)',
        },
    },
}
