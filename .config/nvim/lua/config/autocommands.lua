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

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local lsp_opts = { noremap = true, silent = true, buffer = event.buf }

        lsp_opts.desc = 'Lsp Info'
        vim.keymap.set('n', '<leader>cl', function()
            require('snacks').picker.lsp_config()
        end, lsp_opts) -- show lsp info

        lsp_opts.desc = 'Show References'
        vim.keymap.set('n', 'gR', function()
            require('snacks').picker.lsp_references()
        end, lsp_opts)

        lsp_opts.desc = 'Go to Declaration'
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, lsp_opts) -- go to declaration

        lsp_opts.desc = 'Go to Definition'
        vim.keymap.set('n', 'gd', function()
            require('snacks').picker.lsp_definitions()
        end, lsp_opts)

        lsp_opts.desc = 'Go to Implementation'
        vim.keymap.set('n', 'gi', function()
            require('snacks').picker.lsp_implementations()
        end, lsp_opts)

        lsp_opts.desc = 'Show LSP type definitions'
        vim.keymap.set('n', 'gt', function()
            require('snacks').picker.lsp_type_definitions()
        end, lsp_opts)

        lsp_opts.desc = 'Code Actions'
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, lsp_opts) -- see available code actions, in visual mode will apply to selection

        lsp_opts.desc = 'Smart rename'
        vim.keymap.set('n', '<leader>cR', vim.lsp.buf.rename, lsp_opts) -- smart rename

        lsp_opts.desc = 'Line diagnostics'
        vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, lsp_opts) -- show diagnostics for line

        lsp_opts.desc = 'Go to previous diagnostic'
        vim.keymap.set('n', '[d', function()
            vim.diagnostic.jump { count = -1, float = true }
        end, lsp_opts) -- jump to previous diagnostic in buffer

        lsp_opts.desc = 'Go to next diagnostic'
        vim.keymap.set('n', ']d', function()
            vim.diagnostic.jump { count = 1, float = true }
        end, lsp_opts) -- jump to next diagnostic in buffer

        lsp_opts.desc = 'Show documentation for what is under cursor'
        vim.keymap.set('n', 'K', function()
            vim.lsp.buf.hover {
                border = 'single',
                offset_x = 10,
                offset_y = 10,
            }
        end, lsp_opts) -- show documentation for what is under cursor

        lsp_opts.desc = 'Run Codelens'
        vim.keymap.set({ 'n', 'v' }, '<leader>cc', function()
            vim.lsp.codelens.run()
        end, lsp_opts)

        lsp_opts.desc = 'Refresh & Display Codelens'
        vim.keymap.set('n', '<leader>cC', function()
            vim.lsp.codelens.refresh()
        end, lsp_opts)

        lsp_opts.desc = 'Restart LSP'
        vim.keymap.set('n', '<leader>lr', ':LspRestart<CR>', lsp_opts) -- mapping to restart lsp if necessary

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            lsp_opts.desc = '[T]oggle Inlay [H]ints'
            vim.keymap.set('n', '<leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, lsp_opts)
        end
    end,
})
