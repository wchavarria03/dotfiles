local function augroup(name)
    return vim.api.nvim_create_augroup('wchavarria_nvim_' .. name, { clear = true })
end

-- Don't auto commenting new lines
vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = augroup 'checktime',
    callback = function()
        if vim.o.buftype ~= 'nofile' then
            vim.cmd 'checktime'
        end
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = augroup 'highlight_yank',
    callback = function()
        vim.hl.on_yank()
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
    group = augroup 'resize_splits',
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd 'tabdo wincmd ='
        vim.cmd('tabnext ' .. current_tab)
    end,
})

-- Copilot chat keymap to open last chat response
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = 'copilot-*',
    callback = function()
        vim.opt_local.relativenumber = true

        vim.keymap.set('n', '<leader>al', function()
            print(require('CopilotChat').response())
        end, { buffer = true, remap = true, desc = 'Last copilot response' })
    end,
})

-- Fix conceallevel for markdown, gitcommit and txt filetypes
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = vim.api.nvim_create_augroup('edit_text', { clear = true }),
    pattern = { 'gitcommit', 'markdown', 'txt', 'text', 'plaintex', 'typst' },
    desc = 'Enable spell checking and text wrapping for certain filetypes',
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
        vim.opt_local.conceallevel = 2
    end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = augroup 'json_conceal',
    pattern = { 'json', 'jsonc', 'json5' },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})

-- close filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
    group = augroup 'close_with_q',
    pattern = {
        'PlenaryTestPopup',
        'checkhealth',
        'dbout',
        'git',
        'gitsigns-blame',
        'grug-far',
        'help',
        'lspinfo',
        'man',
        'notify',
        'qf',
        'scratch',
        'spectre_panel',
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
