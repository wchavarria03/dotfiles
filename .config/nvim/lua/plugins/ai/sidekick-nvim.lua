local code_prompts = require 'config.prompts.code'
local git_prompts = require 'config.prompts.git'
local github_prompts = require 'config.prompts.github'

return {
    'folke/sidekick.nvim',
    opts = {
        -- add any options here
        cli = {
            gemini = {
                backend = 'gemini-cli',
                enabled = true,
            },
            prompts = {
                review_file = code_prompts.review_current_file,
                explain_Code = code_prompts.explain_code,
                commit_message = git_prompts.generate_commit_message,
                pending_prs = github_prompts.list_pending_prs,
                general_status = github_prompts.general_status,
            },
        },
    },
    keys = {
        {
            '<tab>',
            function()
                -- if there is a next edit, jump to it, otherwise apply it if any
                if require('sidekick').nes_jump_or_apply() then
                    return -- jumped or applied
                end

                -- if you are using Neovim's native inline completions
                if vim.lsp.inline_completion.get() then
                    return
                end

                -- any other things (like snippets) you want to do on <tab> go here.

                -- fall back to normal tab
                return '<tab>'
            end,
            mode = { 'i', 'n' },
            expr = true,
            desc = 'Goto/Apply Next Edit Suggestion',
        },
        {
            '<leader>aa',
            function()
                require('sidekick.cli').toggle { focus = true }
            end,
            desc = 'Sidekick Toggle CLI',
            mode = { 'n', 'v' },
        },
        {
            '<leader>ac',
            function()
                require('sidekick.cli').toggle { name = 'claude', focus = true }
            end,
            desc = 'Sidekick Claude Toggle',
            mode = { 'n', 'v' },
        },
        {
            '<leader>ag',
            function()
                require('sidekick.cli').toggle { name = 'gemini', focus = true }
            end,
            desc = 'Sidekick Gemini Toggle',
            mode = { 'n', 'v' },
        },
        {
            '<leader>ap',
            function()
                require('sidekick.cli').prompt()
            end,
            desc = 'Sidekick Ask Prompt',
            mode = { 'n', 'v' },
        },
    },
}
