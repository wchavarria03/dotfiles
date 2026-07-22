local M = {}

M.plugins = {
    'https://github.com/folke/snacks.nvim',
}

function M.setup()
    local snacks = require 'snacks'

    snacks.setup {
        bigfile = { enabled = true },
        dim = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        quickfile = { enabled = true, exclude = { 'latex' } },
        rename = { enabled = true },
        scroll = { enabled = false },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        picker = {
            gh_issue = {},
            gh_pr = {},
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
    }

    vim.ui.input = snacks.input

    -- Buffer management
    vim.keymap.set('n', '<leader>bd', function()
        snacks.bufdelete()
    end, { desc = 'Delete Buffer' })
    vim.keymap.set('n', '<leader>bo', function()
        snacks.bufdelete().other()
    end, { desc = 'Delete Other Buffers' })
    vim.keymap.set('n', '<leader>]b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
    vim.keymap.set('n', '<leader>[b', '<cmd>bprevious<cr>', { desc = 'Previous Buffer' })
    vim.keymap.set('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
    vim.keymap.set('n', '<leader>bD', '<cmd>:bd<cr>', { desc = 'Delete Buffer and Window' })

    -- Picker commands
    vim.keymap.set('n', '<leader>/', function()
        snacks.picker.grep { hidden = true }
    end, { desc = 'Grep' })

    vim.keymap.set('n', '<leader>ff', function()
        snacks.picker.files { cwd = vim.fn.getcwd() }
    end, { desc = 'Find Files (Current Dir)' })

    vim.keymap.set('n', '<leader>fb', function()
        snacks.picker.buffers()
    end, { desc = 'Buffers' })

    vim.keymap.set('n', '<leader>fg', function()
        snacks.picker.git_files()
    end, { desc = 'Find Files Git' })

    vim.keymap.set('n', '<leader>fr', function()
        snacks.picker.recent()
    end, { desc = 'Recent Files' })

    vim.keymap.set('n', '<leader>:', function()
        snacks.picker.command_history()
    end, { desc = 'Command History' })

    vim.keymap.set('n', '<leader>fc', function()
        snacks.picker.files { cwd = vim.fn.stdpath 'config' }
    end, { desc = 'Find Files Config' })

    vim.keymap.set('n', '<leader>fp', function()
        snacks.picker.projects {
            dev = { '~/work', '~/personal' },
        }
    end, { desc = 'Projects' })

    -- Search / Grep

    vim.keymap.set('n', '<leader>?', function()
        snacks.picker.search_history()
    end, { desc = 'Search History' })

    vim.keymap.set('n', '<leader>sn', function()
        require('snacks').picker.notifications {
            confirm = function(picker, item)
                -- Close the picker
                picker:close()

                -- Get notification details - try different possible structures
                local notif = item.item or item
                local msg = notif.msg or notif.message or vim.inspect(notif)
                local title = notif.title or 'Notification'
                local level = notif.level or 'info'

                -- Create buffer content
                local lines = vim.split(msg, '\n')
                local content = {
                    string.format('%s [%s]', title, level:upper()),
                    string.rep('─', 60),
                    '',
                }
                vim.list_extend(content, lines)

                -- Create floating window
                local buf = vim.api.nvim_create_buf(false, true)
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
                vim.bo[buf].buftype = 'nofile'
                vim.bo[buf].bufhidden = 'wipe'
                vim.bo[buf].filetype = 'markdown'
                vim.bo[buf].modifiable = false

                -- Calculate window size
                local width = math.min(100, vim.o.columns - 10)
                local height = math.min(30, #content + 2)

                -- Create floating window
                vim.schedule(function()
                    local win = vim.api.nvim_open_win(buf, true, {
                        relative = 'editor',
                        width = width,
                        height = height,
                        col = math.floor((vim.o.columns - width) / 2),
                        row = math.floor((vim.o.lines - height) / 2),
                        style = 'minimal',
                        border = 'rounded',
                        title = ' Notification ',
                        title_pos = 'center',
                    })

                    -- Add keymaps to close the window
                    local close_opts = { noremap = true, silent = true, buffer = buf }
                    vim.keymap.set('n', 'q', '<cmd>close<cr>', close_opts)
                    vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', close_opts)
                    vim.keymap.set('n', '<CR>', '<cmd>close<cr>', close_opts)
                end)
            end,
        }
    end, { desc = 'Search Notification History' })

    vim.keymap.set('n', '<leader>sd', function()
        require('snacks').picker.diagnostics()
    end, { desc = 'Diagnostics' })

    vim.keymap.set('n', '<leader>sm', function()
        -- Open messages in a new buffer
        local messages = vim.fn.execute 'messages'
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(messages, '\n'))
        vim.bo[buf].buftype = 'nofile'
        vim.bo[buf].bufhidden = 'wipe'
        vim.bo[buf].filetype = 'messages'
        vim.api.nvim_set_current_buf(buf)
        vim.api.nvim_buf_set_name(buf, 'Messages')
        -- Enable text selection and copying
        vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':bd<CR>', { noremap = true, silent = true })
    end, { desc = 'Show Messages (full)' })

    -- Git
    vim.keymap.set('n', '<leader>go', function()
        snacks.lazygit()
    end, { desc = 'Git Lazy Git (open)' })

    vim.keymap.set('n', '<leader>gl', function()
        require('snacks').lazygit.log()
    end, { desc = 'Git Log' })

    vim.keymap.set('n', '<leader>gB', function()
        snacks.gitbrowse()
    end, { desc = 'Git Browse (open)' })

    vim.keymap.set('n', '<leader>gY', function()
        require('snacks').gitbrowse {
            open = function(url)
                vim.fn.setreg('+', url)
            end,
            notify = false,
        }
    end, { desc = 'Git Browse (copy)' })

    vim.keymap.set('n', '<leader>gi', function()
        require('snacks').gh.issue()
    end, { desc = 'Git Open Issues' })

    vim.keymap.set('n', '<leader>gI', function()
        require('snacks').gh.issue { state = 'all' }
    end, { desc = 'Git All Issues' })

    vim.keymap.set('n', '<leader>gp', function()
        require('snacks').gh.pr()
    end, { desc = 'Git PRs' })

    vim.keymap.set('n', '<leader>gP', function()
        require('snacks').gh.pr { state = 'all' }
    end, { desc = 'Git All PRs' })

    vim.keymap.set('n', '<leader>gb', function()
        require('snacks').picker.git_branches()
    end, { desc = 'Git Branches' })

    vim.keymap.set('n', '<leader>gL', function()
        require('snacks').picker.git_log()
    end, { desc = 'Git Log' })

    vim.keymap.set('n', '<leader>gll', function()
        require('snacks').picker.git_log_line()
    end, { desc = 'Git Log Line' })

    vim.keymap.set('n', '<leader>gs', function()
        require('snacks').picker.git_status()
    end, { desc = 'Git Status' })

    vim.keymap.set('n', '<leader>gS', function()
        require('snacks').picker.git_stash()
    end, { desc = 'Git Stash' })

    vim.keymap.set('n', '<leader>gd', function()
        require('snacks').picker.git_diff()
    end, { desc = 'Git Diff' })

    vim.keymap.set('n', '<leader>gD', function()
        require('snacks').picker.git_log_file()
    end, { desc = 'Git Log File' })

    -- Toggles
    snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
    snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
    snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>tL'
    snacks.toggle.diagnostics():map '<leader>td'
    snacks.toggle.line_number():map '<leader>tl'
    snacks.toggle
        .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = 'Conceal Level' })
        :map '<leader>tc'
    snacks.toggle.treesitter():map '<leader>tT'
    snacks.toggle.dim():map '<leader>tD'
    snacks.toggle.animate():map '<leader>ta'
    snacks.toggle.indent():map '<leader>ti'
    snacks.toggle.scroll():map '<leader>tS'
    snacks.toggle.inlay_hints():map '<leader>th'
    snacks.toggle.zoom():map '<leader>tZ'
    snacks.toggle.zen():map '<leader>tz'
end

return M
