-- Markdown and Notes Support Functions
-- This file contains utility functions for markdown formatting and note-taking

local M = {}

-- Smart checkbox toggle functions
function M.toggle_todo()
    local line = vim.fn.getline('.')
    local indent = line:match('^(%s*)')
    local checkbox_pattern = '^(%s*)- %[([ x])%]'
    local checkbox_match = line:match(checkbox_pattern)
    
    if checkbox_match then
        -- Toggle existing checkbox
        local new_line = line:gsub(checkbox_pattern, '%1- [ ]')
        vim.fn.setline('.', new_line)
    else
        -- Add new checkbox at start of line
        local new_line = indent .. '- [ ] ' .. line:gsub('^%s*', '')
        vim.fn.setline('.', new_line)
    end
end

function M.toggle_done()
    local line = vim.fn.getline('.')
    local indent = line:match('^(%s*)')
    local checkbox_pattern = '^(%s*)- %[([ x])%]'
    local checkbox_match = line:match(checkbox_pattern)
    
    if checkbox_match then
        -- Toggle existing checkbox
        local new_line = line:gsub(checkbox_pattern, '%1- [x]')
        vim.fn.setline('.', new_line)
    else
        -- Add new checkbox at start of line
        local new_line = indent .. '- [x] ' .. line:gsub('^%s*', '')
        vim.fn.setline('.', new_line)
    end
end

-- Visual mode formatting functions
function M.format_bold()
    local saved_reg = vim.fn.getreg('"')
    vim.cmd('normal! y')
    local selected_text = vim.fn.getreg('"')
    vim.fn.setreg('"', '**' .. selected_text .. '**')
    vim.cmd('normal! p')
    vim.fn.setreg('"', saved_reg)
end

function M.format_italic()
    local saved_reg = vim.fn.getreg('"')
    vim.cmd('normal! y')
    local selected_text = vim.fn.getreg('"')
    vim.fn.setreg('"', '*' .. selected_text .. '*')
    vim.cmd('normal! p')
    vim.fn.setreg('"', saved_reg)
end

function M.format_code()
    local saved_reg = vim.fn.getreg('"')
    vim.cmd('normal! y')
    local selected_text = vim.fn.getreg('"')
    vim.fn.setreg('"', '`' .. selected_text .. '`')
    vim.cmd('normal! p')
    vim.fn.setreg('"', saved_reg)
end

function M.format_strikethrough()
    local saved_reg = vim.fn.getreg('"')
    vim.cmd('normal! y')
    local selected_text = vim.fn.getreg('"')
    vim.fn.setreg('"', '~~' .. selected_text .. '~~')
    vim.cmd('normal! p')
    vim.fn.setreg('"', saved_reg)
end

-- Header insertion functions
function M.insert_header(level)
    local header_markers = string.rep('#', level)
    vim.cmd('normal! i' .. header_markers .. ' ')
end

-- Code block functions
function M.insert_code_block()
    vim.cmd('normal! i```\n\n```')
    vim.cmd('normal! k')
end

function M.insert_inline_code()
    vim.cmd('normal! i`')
end

-- List functions
function M.insert_unordered_list()
    vim.cmd('normal! i- ')
end

function M.insert_ordered_list()
    vim.cmd('normal! i1. ')
end

-- Quote and horizontal rule functions
function M.insert_quote()
    vim.cmd('normal! i> ')
end

function M.insert_horizontal_rule()
    vim.cmd('normal! i---')
    vim.cmd('normal! o')
end

-- Link function
function M.insert_link()
    vim.cmd('normal! i[]()')
    vim.cmd('normal! 2h')
end

-- Notes folder function
function M.open_notes_folder()
    vim.cmd('e ~/Library/Mobile\\ Documents/com~apple~CloudDocs/notes/')
end

-- Zen mode function
function M.toggle_zen_mode()
    vim.cmd('ZenMode')
end

return M 