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
                        require('utils.lualine_components').copilot_status,
                        cond = function()
                            return package.loaded['copilot'] ~= nil
                        end,
                    },
                    {
                        function()
                            return ' '
                        end,
                        color = function()
                            local status = require('sidekick.status').get()
                            if status then
                                return status.kind == 'Error' and 'DiagnosticError'
                                    or status.busy and 'DiagnosticWarn'
                                    or 'Special'
                            end
                        end,
                        cond = function()
                            local status = require 'sidekick.status'
                            return status.get() ~= nil
                        end,
                    },
                    {
                        function()
                            -- Check if MCPHub is loaded
                            if not vim.g.loaded_mcphub then
                                return '󰐻 -'
                            end

                            local count = vim.g.mcphub_servers_count or 0
                            local status = vim.g.mcphub_status or 'stopped'
                            local executing = vim.g.mcphub_executing

                            -- Show "-" when stopped
                            if status == 'stopped' then
                                return '󰐻 -'
                            end

                            -- Show spinner when executing, starting, or restarting
                            if executing or status == 'starting' or status == 'restarting' then
                                local frames = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
                                local frame = math.floor(vim.loop.now() / 100) % #frames + 1
                                return '󰐻 ' .. frames[frame]
                            end

                            return '󰐻 ' .. count
                        end,
                        color = function()
                            if not vim.g.loaded_mcphub then
                                return { fg = '#6c7086' } -- Gray for not loaded
                            end

                            local status = vim.g.mcphub_status or 'stopped'
                            if status == 'ready' or status == 'restarted' then
                                return { fg = '#50fa7b' } -- Green for connected
                            elseif status == 'starting' or status == 'restarting' then
                                return { fg = '#ffb86c' } -- Orange for connecting
                            else
                                return { fg = '#ff5555' } -- Red for error/stopped
                            end
                        end,
                    },
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
