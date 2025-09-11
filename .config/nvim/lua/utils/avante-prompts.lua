-- Main Avante prompts module - imports from separate modules
local M = {}

-- Import all prompt modules
local git = require('config.avante.git')
local github = require('config.avante.github')
local code = require('config.avante.code')
local templates = require('config.avante.templates')

-- Re-export all functions for backward compatibility
M.generate_commit_message = git.generate_commit_message
M.list_pending_prs = github.list_pending_prs
M.review_current_file = code.review_current_file
M.explain_code = code.explain_code
M.general_status = github.general_status
M.custom_prompt_template = templates.custom_prompt_template

return M 