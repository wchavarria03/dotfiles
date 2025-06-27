-- Git-related Avante prompts
local M = {}
local helpers = require('config.avante.helpers')

-- Generate commit message prompt
function M.generate_commit_message()
    local staged_diff, error_msg = helpers.get_staged_diff()
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

return M 