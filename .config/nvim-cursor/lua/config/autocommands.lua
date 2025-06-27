local function augroup(name)
    return vim.api.nvim_create_augroup('wchavarria_nvim_' .. name, { clear = true })
end

-- Highlight on yank (disabled for VS Code compatibility)
-- vim.api.nvim_create_autocmd('TextYankPost', {
--     desc = 'Highlight when yanking (copying) text',
--     group = augroup 'highlight_yank',
--     callback = function()
--         vim.hl.on_yank()
--     end,
-- })

-- Filetype-specific settings
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = vim.api.nvim_create_augroup('edit_text', { clear = true }),
    pattern = { 'gitcommit', 'markdown', 'txt', 'text', 'plaintex', 'typst' },
    desc = 'Enable spell checking and text wrapping for certain filetypes',
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
        vim.opt_local.conceallevel = 0  -- Keep conceal disabled
    end,
})

-- Close filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
    group = augroup 'close_with_q',
    pattern = {
        'PlenaryTestPopup',
        'checkhealth',
        'dbout',
        'git',
        'gitsigns-blame',
        'help',
        'lspinfo',
        'man',
        'notify',
        'qf',
        'scratch',
        'startuptime',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set('n', 'q', function()
                vim.cmd 'close'
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = 'Quit buffer',
            })
        end)
    end,
})