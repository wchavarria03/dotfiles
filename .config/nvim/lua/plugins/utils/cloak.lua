local M = {}

M.plugins = {
    'https://github.com/laytan/cloak.nvim',
}

function M.setup()
    require('cloak').setup {
        enabled = true,
        cloak_character = '*',
        highlight_group = 'Comment',
        patterns = {
            {
                file_pattern = {
                    '.env*',
                    'env.*',
                    '.dev*',
                    'dev.*',
                    '*-secrets.zsh',
                    'git.inc',
                    'hosts.json',
                    'config.json',
                    'secrets.json',
                    'credentials.json',
                },
                cloak_pattern = {
                    '=.+',
                    { '(https://ghp_).+', replace = '%1' },
                    { '("oauth_token": "ghu_).+', replace = '%1' },
                    { '("token" : ).+', replace = '%1' },
                    { '("accesstoken" :).+', replace = '%1' },
                },
            },
        },
    }

    require('snacks')
        .toggle {
            name = 'Cloak',
            get = function()
                return vim.b.cloak_enabled
            end,
            set = function(state)
                require('cloak').toggle(state)
            end,
        }
        :map '<leader>tC'
end

return M
