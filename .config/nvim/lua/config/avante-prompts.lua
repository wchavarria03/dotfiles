-- Custom Avante prompts for common tasks
local M = {}

-- Function to get git diff for staged changes
local function get_staged_diff()
    local staged_diff = vim.fn.system("git diff --cached")
    if staged_diff == "" then
        return nil, "No staged changes found."
    end
    return staged_diff, nil
end

-- Function to get pending PRs data
local function get_pending_prs()
    local pr_data = vim.fn.system("gh search prs --review-requested @me --limit 20 --json title,url,repository,author,createdAt,updatedAt")
    if pr_data == "" then
        return nil, "No pending PR reviews found or gh CLI not available."
    end
    return pr_data, nil
end

-- Function to get current file content
local function get_current_file_content()
    local current_file = vim.fn.expand("%:p")
    local file_content = vim.fn.readfile(current_file)
    local file_content_str = table.concat(file_content, "\n")
    return current_file, file_content_str
end

-- Generate commit message prompt
function M.generate_commit_message()
    local staged_diff, error_msg = get_staged_diff()
    if not staged_diff then
        vim.notify(error_msg, vim.log.levels.WARN)
        return
    end
    
    return string.format([[
Generate a conventional commit message for the following staged changes.

Git diff of staged changes:
%s

Please follow the conventional commit format:
- type(scope): description
- Use lowercase for type and description
- Common types: feat, fix, docs, style, refactor, test, chore, perf, ci, build
- Keep description under 50 characters
- If breaking change, add ! after type and include BREAKING CHANGE: in body

Return only the commit message, no explanations.
]], staged_diff)
end

-- List pending PRs prompt
function M.list_pending_prs()
    local pr_data, error_msg = get_pending_prs()
    if not pr_data then
        vim.notify(error_msg, vim.log.levels.WARN)
        return
    end
    
    return string.format([[
Analyze the following GitHub PR data and provide a clear summary of pull requests that require my review:

%s

Please format the output as:
1. Repository: PR Title (Author)
   - Created: Date
   - Updated: Date
   - URL: Link

Sort by most recently updated first. If there are no PRs, just say "No pending PR reviews found."
]], pr_data)
end

-- Review current file prompt
function M.review_current_file()
    local current_file, file_content = get_current_file_content()
    
    return string.format([[
Please review the following code file: %s

Code content:
%s

Please provide a code review focusing on:
1. Code quality and best practices
2. Potential bugs or issues
3. Performance considerations
4. Security concerns
5. Suggestions for improvement

Be constructive and specific in your feedback.
]], current_file, file_content)
end

-- Explain code prompt
function M.explain_code()
    local current_file, file_content = get_current_file_content()
    
    return string.format([[
Please explain the following code file: %s

Code content:
%s

Please provide a clear explanation of:
1. What this code does
2. How it works
3. Key functions and their purposes
4. Any important patterns or concepts used

Make it easy to understand for someone new to this codebase.
]], current_file, file_content)
end

-- Add more custom prompts here as needed
function M.custom_prompt_template()
    return [[
This is a template for custom prompts. You can add your own prompts here.

Example:
- Code optimization suggestions
- Documentation generation
- Test case generation
- Bug analysis
- Performance analysis
- Security review
- Code refactoring suggestions
]]
end

return M 