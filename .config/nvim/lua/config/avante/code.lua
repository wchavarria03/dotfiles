-- Code analysis Avante prompts
local M = {}
local helpers = require('config.avante.helpers')

-- Review current file prompt
function M.review_current_file()
    local current_file, file_content = helpers.get_current_file_content()
    
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
    local current_file, file_content = helpers.get_current_file_content()
    
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

return M 