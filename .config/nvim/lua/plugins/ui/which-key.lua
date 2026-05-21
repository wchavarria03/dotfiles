local M = {}

M.plugins = {
    'https://github.com/folke/which-key.nvim',
}

function M.setup()
    require('which-key').setup {
        preset = 'helix',
        plugins = { spelling = true },
        defaults = {},
        spec = {
            {
                mode = { 'n', 'v' },
                { '<leader>a', group = 'ai', icon = { icon = '󱚦 ', color = 'cyan' } },
                {
                    '<leader>b',
                    group = 'buffer',
                    icon = { icon = '󰈙 ', color = 'blue' },
                    expand = function()
                        return require('which-key.extras').expand.buf()
                    end,
                },
                { '<leader>c', group = 'code', icon = { icon = ' ', color = 'orange' } },
                { '<leader>f', group = 'find/file', icon = { icon = '󰍉 ', color = 'blue' } },
                { '<leader>g', group = 'git', icon = { icon = '󰊢 ', color = 'orange' } },
                { '<leader>gh', group = 'hunks', icon = { icon = '󱓉 ', color = 'green' } },
                { '<leader>i', group = 'image', icon = { icon = '󰋩 ', color = 'purple' } },
                { '<leader>k', group = 'kulala/requests', icon = { icon = '󰖟 ', color = 'blue' } },
                { '<leader>l', group = 'lsp', icon = { icon = '󰒊 ', color = 'green' } },
                { '<leader>m', group = 'markdown', icon = { icon = '󰍔 ', color = 'blue' } },
                { '<leader>n', group = 'notes', icon = { icon = '󰠮 ', color = 'yellow' } },
                { '<leader>nt', group = 'todos', icon = { icon = '󰅚 ', color = 'red' } },
                { '<leader>p', group = 'pack', icon = { icon = '󰏗 ', color = 'orange' } },
                { '<leader>q', group = 'quit/session', icon = { icon = '󰗼 ', color = 'red' } },
                { '<leader>r', group = 'resize', icon = { icon = '󰩨 ', color = 'grey' } },
                { '<leader>s', group = 'search', icon = { icon = '󰍉 ', color = 'blue' } },
                { '<leader>t', group = 'toggle', icon = { icon = '󰔡 ', color = 'cyan' } },
                { '<leader>tg', group = 'git', icon = { icon = '󰙵 ', color = 'cyan' } },
                { '<leader>u', group = 'ui', icon = { icon = '󰙵 ', color = 'cyan' } },
                {
                    '<leader>w',
                    group = 'windows',
                    icon = { icon = ' ', color = 'blue' },
                    proxy = '<c-w>',
                    expand = function()
                        return require('which-key.extras').expand.win()
                    end,
                },
                { '<leader>x', group = 'diagnostics/quickfix', icon = { icon = '󱖫 ', color = 'green' } },
                { '[', group = 'prev' },
                { ']', group = 'next' },
                { 'g', group = 'goto' },
                { 'gs', group = 'surround' },
                { 'gx', desc = 'Open with system app' },
                { 'z', group = 'fold' },
            },
        },
    }
end

return M
