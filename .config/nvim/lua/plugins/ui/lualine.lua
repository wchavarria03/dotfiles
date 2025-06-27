return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
        local opts = {
            options = {
                theme = 'auto',
                globalstatus = true,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = {
                    { 'filename', path = 1 },
                },
                lualine_x = {
                    {
                        function()
                            local clients = vim.lsp.get_clients { name = 'copilot', bufnr = 0 }
                            if #clients > 0 then
                                local status = require('copilot.api').status.data.status
                                return (status == 'InProgress' and '...')
                                    or (status == 'Warning' and 'X')
                                    or ''
                            end
                            return ''
                        end,
                        cond = function()
                            return package.loaded['copilot'] ~= nil
                        end,
                    },
                    { require 'mcphub.extensions.lualine' },
                    { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
                },
                lualine_y = {
                    { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
                },
                lualine_z = {
                    { 'location', padding = { left = 0, right = 1 } },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {
                lualine_a = { { 'buffers', mode = 2, use_mode_colors = true } },
            },
            extensions = { 'neo-tree', 'lazy', 'trouble', 'mason' },
        }

        return opts
    end,
}
