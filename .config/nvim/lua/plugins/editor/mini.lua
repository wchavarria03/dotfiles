local M = {}

M.plugins = {
    'https://github.com/echasnovski/mini.nvim',
}

function M.setup()
    -- mini.files
    require('mini.files').setup {
        mappings = {
            go_in = '<CR>',
            go_in_plus = 'L',
            go_out = '-',
            go_out_plus = 'H',
        },
        options = {
            parmanent_delete = false,
            use_as_default_explorer = true,
        },
    }

    vim.keymap.set('n', '<leader>e', function()
        require('mini.files').open(vim.api.nvim_buf_get_name(0), false)
        require('mini.files').reveal_cwd()
    end, { desc = 'Toggle Explorer Current File' })

    vim.keymap.set('n', '<leader>E', function()
        require('mini.files').open()
    end, { desc = 'Toggle Explorer Directory' })

    -- mini.ai
    local ai = require('mini.ai')
    require('mini.ai').setup {
        n_lines = 500,
        custom_textobjects = {
            o = ai.gen_spec.treesitter({
                a = { '@block.outer', '@conditional.outer', '@loop.outer' },
                i = { '@block.inner', '@conditional.inner', '@loop.inner' },
            }),
            f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
            c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
            t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
            d = { '%f[%d]%d+' },
            e = {
                { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
                '^().*()$',
            },
            u = ai.gen_spec.function_call(),
            U = ai.gen_spec.function_call({ name_pattern = '[%w_]' }),
        },
    }

    -- mini.pairs
    require('mini.pairs').setup {
        modes = { insert = true, command = false, terminal = false },
        mappings = {
            [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
            [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
            ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
            ['['] = { action = 'open', pair = '[]', neigh_pattern = '.[%s%z%)}%]]', register = { cr = false } },
            ['{'] = { action = 'open', pair = '{}', neigh_pattern = '.[%s%z%)}%]]', register = { cr = false } },
            ['('] = { action = 'open', pair = '()', neigh_pattern = '.[%s%z%)]', register = { cr = false } },
            ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^%w\\][^%w]', register = { cr = false } },
            ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%w\\][^%w]', register = { cr = false } },
            ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^%w\\][^%w]', register = { cr = false } },
        },
    }

    -- mini.surround
    require('mini.surround').setup {}
end

return M
