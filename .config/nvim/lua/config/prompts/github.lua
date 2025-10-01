-- GitHub-related prompts
local M = {}
local helpers = require 'config.prompts.helpers'

-- List pending PRs prompt
function M.list_pending_prs()
    local pr_data, error_msg = helpers.get_pending_prs()
    if not pr_data then
        vim.notify(error_msg, vim.log.levels.WARN)
        return
    end

    return 'Summarize these PRs that need review:\n\n' .. pr_data
end

-- General status prompt
function M.general_status()
    local pending_prs, pending_error = helpers.get_pending_prs()
    local my_prs, my_prs_error = helpers.get_my_open_prs()
    local yesterdays_commits, commits_error = helpers.get_yesterdays_commits()

    local prompt = 'Provide a brief status report:\n\n'

    if pending_prs then
        prompt = prompt .. 'PENDING REVIEWS:\n' .. pending_prs .. '\n\n'
    else
        prompt = prompt .. 'PENDING REVIEWS: ' .. (pending_error or 'None') .. '\n\n'
    end

    if my_prs then
        prompt = prompt .. 'MY OPEN PRs:\n' .. my_prs .. '\n\n'
    else
        prompt = prompt .. 'MY OPEN PRs: ' .. (my_prs_error or 'None') .. '\n\n'
    end

    if yesterdays_commits then
        prompt = prompt .. "YESTERDAY'S WORK:\n" .. yesterdays_commits .. '\n\n'
    else
        prompt = prompt .. "YESTERDAY'S WORK: " .. (commits_error or 'None') .. '\n\n'
    end

    prompt = prompt .. "Summarize briefly: pending reviews, your open PRs, and yesterday's work."

    return prompt
end

return M

