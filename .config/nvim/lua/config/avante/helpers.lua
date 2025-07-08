-- Helper functions for Avante prompts
local M = {}

-- Function to get git diff for staged changes
function M.get_staged_diff()
    -- Check if we're in a git repository
    local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null")
    if git_root == "" then
        return nil, "Not in a git repository."
    end
    
    local staged_diff = vim.fn.system("git diff --cached")
    if staged_diff == "" then
        return nil, "No staged changes found."
    end
    return staged_diff, nil
end

-- Function to get pending PRs data
function M.get_pending_prs()
    -- Check if gh CLI is available
    if vim.fn.executable("gh") == 0 then
        return nil, "GitHub CLI (gh) is not installed or not in PATH."
    end
    
    local pr_data = vim.fn.system("gh search prs --review-requested @me --limit 10 --json title,url,repository 2>/dev/null")
    if pr_data == "" or vim.v.shell_error ~= 0 then
        return nil, "No pending PR reviews found or not authenticated with GitHub CLI."
    end
    return pr_data, nil
end

-- Function to get open PRs created by me
function M.get_my_open_prs()
    -- Check if gh CLI is available
    if vim.fn.executable("gh") == 0 then
        return nil, "GitHub CLI (gh) is not installed or not in PATH."
    end
    
    local pr_data = vim.fn.system("gh search prs --author @me --state open --limit 10 --json title,url,repository 2>/dev/null")
    if pr_data == "" or vim.v.shell_error ~= 0 then
        return nil, "No open PRs found or not authenticated with GitHub CLI."
    end
    return pr_data, nil
end

-- Function to get yesterday's commits
function M.get_yesterdays_commits()
    -- Check if gh CLI is available
    if vim.fn.executable("gh") == 0 then
        return nil, "GitHub CLI (gh) is not installed or not in PATH."
    end
    
    local yesterday = vim.fn.system("date -v-1d +%Y-%m-%d 2>/dev/null")
    if yesterday == "" or vim.v.shell_error ~= 0 then
        -- Fallback for non-macOS systems
        yesterday = vim.fn.system("date -d 'yesterday' +%Y-%m-%d 2>/dev/null")
        if yesterday == "" or vim.v.shell_error ~= 0 then
            return nil, "Could not determine yesterday's date."
        end
    end
    yesterday = vim.fn.trim(yesterday)
    
    -- Use GitHub CLI to search for commits by author with simple output
    local gh_cmd = string.format("gh search commits --author=@me --committer-date='%s' --limit 20 2>/dev/null", yesterday)
    local commits_data = vim.fn.system(gh_cmd)
    
    if not commits_data or commits_data == "" or vim.v.shell_error ~= 0 then
        return nil, string.format("No commits found for yesterday (%s) or not authenticated with GitHub CLI.", yesterday)
    end
    
    -- Just return the simple output without parsing
    return commits_data, yesterday
end

-- Function to get current file content
function M.get_current_file_content()
    local current_file = vim.fn.expand("%:p")
    if current_file == "" then
        return nil, "No file is currently open."
    end
    
    local file_content = vim.fn.readfile(current_file)
    if not file_content or #file_content == 0 then
        return current_file, ""
    end
    
    local file_content_str = table.concat(file_content, "\n")
    return current_file, file_content_str
end

return M 