local bufnr = vim.api.nvim_get_current_buf()
local omnifunc = vim.api.nvim_buf_get_option(bufnr, 'omnifunc')
print(omnifunc)
