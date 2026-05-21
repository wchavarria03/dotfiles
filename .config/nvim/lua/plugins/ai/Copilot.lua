local M = {}

M.plugins = {
    'https://github.com/zbirenbaum/copilot.lua',
}

function M.setup()
    require('copilot').setup {
        panel = { enabled = false },
        suggestion = { enabled = false },
        nes = { enabled = true },
        filetypes = {
            yaml = true,
            markdown = true,
            help = true,
            gitcommit = true,
            gitrebase = true,
            ['.'] = false,
        },
        copilot_model = '',
        server_opts_overrides = {
            trace = 'verbose',
            settings = {
                advanced = {
                    listCount = 10,
                    inlineSuggestCount = 3,
                },
            },
        },
    }
end

return M
