-- Autocommands for notes

-- Create augroup for better organization
local notes_group = vim.api.nvim_create_augroup("NotesConfig", { clear = true })

-- Markdown-specific settings
vim.api.nvim_create_autocmd('FileType', {
  group = notes_group,
  pattern = 'markdown',
  callback = function()
    -- Text formatting
    vim.opt_local.textwidth = 80
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
    vim.opt_local.conceallevel = 2
  end
})

-- Auto-save on focus lost
vim.api.nvim_create_autocmd('FocusLost', {
  group = notes_group,
  pattern = '*',
  command = 'silent! wa'
})

-- Auto-save on text change (with debounce)
local save_timer = nil
vim.api.nvim_create_autocmd('TextChanged', {
  group = notes_group,
  pattern = '*',
  callback = function()
    if save_timer then
      vim.loop.timer_stop(save_timer)
    end
    save_timer = vim.defer_fn(function()
      vim.cmd('silent! wa')
    end, 1000) -- Save after 1 second of inactivity
  end
})

-- Highlight trailing whitespace
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = notes_group,
  pattern = '*',
  callback = function()
    vim.cmd('match ErrorMsg /\\s\\+$/')
  end
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = notes_group,
  pattern = '*',
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end
}) 