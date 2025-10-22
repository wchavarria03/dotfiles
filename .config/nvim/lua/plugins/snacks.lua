return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dim = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        quickfile = { enabled = true, exclude = { 'latex' } },
        rename = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        picker = {
            matcher = {
                frecency = true,
            },
            sources = {
                files = { hidden = true },
            },
        },
        lazygit = {},
        gitbrowse = {
            enabled = true,
        },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        zen = {},
    },
    keys = {
        -- Buffer management
        {
            '<leader>bd',
            function()
                require('snacks').bufdelete()
            end,
            desc = 'Delete Buffer',
        },
        {
            '<leader>bo',
            function()
                require('snacks').bufdelete.other()
            end,
            desc = 'Delete Other Buffers',
        },
        { '<leader>[b', '<cmd>bnext<cr>', desc = 'Next Buffer' },
        { '<leader>]b', '<cmd>bprevious<cr>', desc = 'Previous Buffer' },
        { '<leader>bb', '<cmd>e #<cr>', desc = 'Switch to Other Buffer' },
        { '<leader>bD', '<cmd>:bd<cr>', desc = 'Delete Buffer and Window' },

        -- Picker commands
        {
            '<leader>/',
            function()
                require('snacks').picker.grep { hidden = true }
            end,
            desc = 'Grep',
        },
        {
            '<leader>:',
            function()
                require('snacks').picker.command_history()
            end,
            desc = 'Command History',
        },
        -- find
        {
            '<leader>ff',
            function()
                require('snacks').picker.files { cwd = vim.fn.getcwd() }
            end,
            desc = 'Find Files (Current Dir)',
        },
        {
            '<leader>fb',
            function()
                require('snacks').picker.buffers()
            end,
            desc = 'Buffers',
        },
        {
            '<leader>fc',
            function()
                require('snacks').picker.files { cwd = vim.fn.stdpath 'config' }
            end,
            desc = 'Find Files Config',
        },
        {
            '<leader>fg',
            function()
                require('snacks').picker.git_files()
            end,
            desc = 'Find Files Git',
        },
        {
            '<leader>fp',
            function()
                require('snacks').picker.projects {
                    dev = { '~/work', '~/personal' },
                }
            end,
            desc = 'Projects',
        },
        {
            '<leader>fr',
            function()
                require('snacks').picker.recent()
            end,
            desc = 'Recent',
        },
        -- Grep
        {
            '<leader>sb',
            function()
                require('snacks').picker.lines()
            end,
            desc = 'Search Buffer Lines',
        },
        {
            '<leader>sB',
            function()
                require('snacks').picker.grep_buffers()
            end,
            desc = 'Search Open Buffers',
        },
        {
            '<leader>sn',
            function()
                require('snacks').picker.notifications()
            end,
            desc = 'Search Notification History',
        },
        {
            '<leader>sw',
            function()
                require('snacks').picker.grep_word()
            end,
            desc = 'Visual selection or word',
            mode = { 'n', 'x' },
        },
        -- search
        {
            '<leader>s"',
            function()
                require('snacks').picker.registers()
            end,
            desc = 'Registers',
        },
        {
            '<leader>s/',
            function()
                require('snacks').picker.search_history()
            end,
            desc = 'Search History',
        },
        {
            '<leader>sa',
            function()
                require('snacks').picker.autocmds()
            end,
            desc = 'Autocmds',
        },
        {
            '<leader>sc',
            function()
                require('snacks').picker.command_history()
            end,
            desc = 'Command History',
        },
        {
            '<leader>sC',
            function()
                require('snacks').picker.commands()
            end,
            desc = 'Commands',
        },
        {
            '<leader>sd',
            function()
                require('snacks').picker.diagnostics()
            end,
            desc = 'Diagnostics',
        },
        {
            '<leader>sD',
            function()
                require('snacks').picker.diagnostics_buffer()
            end,
            desc = 'Buffer Diagnostics',
        },
        {
            '<leader>sh',
            function()
                require('snacks').picker.help()
            end,
            desc = 'Help Pages',
        },
        {
            '<leader>sH',
            function()
                require('snacks').picker.highlights()
            end,
            desc = 'Highlights',
        },
        {
            '<leader>si',
            function()
                require('snacks').picker.icons()
            end,
            desc = 'Icons',
        },
        {
            '<leader>sj',
            function()
                require('snacks').picker.jumps()
            end,
            desc = 'Jumps',
        },
        {
            '<leader>sk',
            function()
                require('snacks').picker.keymaps()
            end,
            desc = 'Keymaps',
        },
        {
            '<leader>sl',
            function()
                require('snacks').picker.loclist()
            end,
            desc = 'Location List',
        },
        {
            '<leader>sm',
            function()
                require('snacks').picker.marks()
            end,
            desc = 'Marks',
        },
        {
            '<leader>sM',
            function()
                require('snacks').picker.man()
            end,
            desc = 'Man Pages',
        },
        {
            '<leader>sp',
            function()
                require('snacks').picker.lazy()
            end,
            desc = 'Search for Plugin Spec',
        },
        {
            '<leader>sq',
            function()
                require('snacks').picker.qflist()
            end,
            desc = 'Quickfix List',
        },
        {
            '<leader>sr',
            function()
                require('snacks').picker.resume()
            end,
            desc = 'Resume Last Picker',
        },
        {
            '<leader>su',
            function()
                require('snacks').picker.undo()
            end,
            desc = 'Undo Tree',
        },
        {
            '<leader>ss',
            function()
                require('snacks').picker.lsp_symbols()
            end,
            desc = 'LSP Symbols',
        },
        {
            '<leader>sS',
            function()
                require('snacks').picker.lsp_workspace_symbols()
            end,
            desc = 'LSP Workspace Symbols',
        },
        {
            '<leader>st',
            function()
                require('snacks').picker.colorschemes()
            end,
            desc = 'Colorschemes',
        },
        -- Git
        {
            '<leader>go',
            function()
                require('snacks').lazygit()
            end,
            desc = 'Git Lazy Git (open)',
        },
        {
            '<leader>gl',
            function()
                require('snacks').lazygit.log()
            end,
            desc = 'Git Log',
        },
        {
            '<leader>gB',
            function()
                require('snacks').gitbrowse()
            end,
            desc = 'Git Browse (open)',
        },
        {
            '<leader>gY',
            function()
                require('snacks').gitbrowse {
                    open = function(url)
                        vim.fn.setreg('+', url)
                    end,
                    notify = false,
                }
            end,
            desc = 'Git Browse (copy)',
        },
        {
            '<leader>gb',
            function()
                require('snacks').picker.git_branches()
            end,
            desc = 'Git Branches',
        },
        {
            '<leader>gL',
            function()
                require('snacks').picker.git_log()
            end,
            desc = 'Git Log',
        },
        {
            '<leader>gll',
            function()
                require('snacks').picker.git_log_line()
            end,
            desc = 'Git Log Line',
        },
        {
            '<leader>gs',
            function()
                require('snacks').picker.git_status()
            end,
            desc = 'Git Status',
        },
        {
            '<leader>gS',
            function()
                require('snacks').picker.git_stash()
            end,
            desc = 'Git Stash',
        },
        {
            '<leader>gd',
            function()
                require('snacks').picker.git_diff()
            end,
            desc = 'Git Diff',
        },
        {
            '<leader>gD',
            function()
                require('snacks').picker.git_log_file()
            end,
            desc = 'Git Log File',
        },
        {
            '<leader>z',
            function()
                require('snacks').zen()
            end,
            desc = 'Zen Mode',
        },
    },
    config = function(_, opts)
        require('snacks').setup(opts)
        vim.ui.input = require('snacks').input
    end,
}

