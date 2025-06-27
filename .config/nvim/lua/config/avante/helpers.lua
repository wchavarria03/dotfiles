-- Helper functions for Avante prompts
local M = {}

-- Function to get git diff for staged changes
function M.get_staged_diff()
    local staged_diff = vim.fn.system("git diff --cached")
    if staged_diff == "" then
        return nil, "No staged changes found."
    end
    return staged_diff, nil
end

-- Function to get pending PRs data
function M.get_pending_prs()
    local pr_data = vim.fn.system("gh search prs --review-requested @me --limit 10 --json title,url,repository")
    if pr_data == "" then
        return nil, "No pending PR reviews found or gh CLI not available."
    end
    return pr_data, nil
end

-- Function to get open PRs created by me
function M.get_my_open_prs()
    local pr_data = vim.fn.system("gh search prs --author @me --state open --limit 10 --json title,url,repository")
    if pr_data == "" then
        return nil, "No open PRs found or gh CLI not available."
    end
    return pr_data, nil
end

-- Function to get yesterday's commits
function M.get_yesterdays_commits()
    local yesterday = vim.fn.system("date -v-1d +%Y-%m-%d")
    yesterday = vim.fn.trim(yesterday)
    
    -- Use GitHub CLI to search for commits by author with simple output
    local gh_cmd = string.format("gh search commits --author=@me --committer-date='%s' --limit 20", yesterday)
    local commits_data = vim.fn.system(gh_cmd)
    
    if not commits_data or commits_data == "" then
        return nil, string.format("No commits found for yesterday (%s).", yesterday)
    end
    
    -- Just return the simple output without parsing
    return commits_data, yesterday
end

-- Function to get current file content
function M.get_current_file_content()
    local current_file = vim.fn.expand("%:p")
    local file_content = vim.fn.readfile(current_file)
    local file_content_str = table.concat(file_content, "\n")
    return current_file, file_content_str
end

return M 