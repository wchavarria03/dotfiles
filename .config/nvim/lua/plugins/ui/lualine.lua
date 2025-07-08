return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
        local opts = {
            options = {
                theme = 'auto',
                globalstatus = true,
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = {
                    { 'filename', path = 1 },
                },
                lualine_x = {
                    {
                        require('config.lualine_components').copilot_status,
                        cond = function()
                            return package.loaded['copilot'] ~= nil
                        end,
                    },
                    { require 'mcphub.extensions.lualine' },
                    { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
                },
                lualine_y = {
                    { 'progress' },
                },
                lualine_z = {
                    { 'location', separator = '' },
                    {
                        function()
                            return ''
                        end,
                        padding = { left = 0, right = 1 },
                    },
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
