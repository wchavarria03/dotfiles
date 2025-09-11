vim.lsp.enable 'bash_ls'
vim.lsp.enable 'biome_ls'
vim.lsp.enable 'docker_compose_ls'
vim.lsp.enable 'docker_ls'
vim.lsp.enable 'golangci_lint_ls'
vim.lsp.enable 'gopls'
vim.lsp.enable 'html_ls'
vim.lsp.enable 'json_ls'
vim.lsp.enable 'lua_ls'
vim.lsp.enable 'marksman'
vim.lsp.enable 'pyright'
vim.lsp.enable 'ruff'
vim.lsp.enable 'solidity_ls'
vim.lsp.enable 'stylelint_lsp'
vim.lsp.enable 'taplo_ls'
vim.lsp.enable 'terraform_ls'
vim.lsp.enable 'tflint'
vim.lsp.enable 'yaml_ls'

-- Only configure LSP if blink.cmp is available
local ok, blink_cmp = pcall(require, 'blink.cmp')
if ok then
    vim.lsp.config('*', {
        capabilities = blink_cmp.get_lsp_capabilities(),
        root_markers = { '.git' },
    })
else
    -- Fallback configuration without blink.cmp
    vim.lsp.config('*', {
        root_markers = { '.git' },
    })
end

vim.diagnostic.config {
    underline = true,
    update_in_insert = false,
    virtual_text = true,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = true,
    },
}

local function get_active_lsp_names(bufnr)
    local clients = vim.lsp.get_clients { bufnr = bufnr }
    local names = {}
    for _, client in ipairs(clients) do
        table.insert(names, client.name)
    end
    return names
end

local function print_active_lsp_names(bufnr)
    local names = get_active_lsp_names(bufnr)
    local message = ''
    if #names > 0 then
        message = 'Active LSP servers for buffer ' .. bufnr .. ':\n'
        for _, name in ipairs(names) do
            message = message .. '- ' .. name .. '\n'
        end
    else
        message = 'No active LSP servers for buffer ' .. bufnr .. '.'
    end
    vim.notify(message, vim.log.levels.INFO)
end

local function print_detailed_lsp_info(bufnr)
    local clients = vim.lsp.get_clients { bufnr = bufnr }
    local message = ''
    if #clients > 0 then
        message = 'Active LSP servers for buffer ' .. bufnr .. ':\n'
        for _, client in ipairs(clients) do
            message = message .. '--------------------\n'
            message = message .. 'Name: ' .. client.name .. '\n'
            message = message .. 'ID: ' .. client.id .. '\n'
            message = message .. 'Capabilities:\n'
            for capability, enabled in pairs(client.capabilities) do
                if enabled then
                    message = message .. '  - ' .. capability .. '\n'
                end
            end
            message = message .. 'Attached Filetypes: ' .. table.concat(client.config.filetypes or {}, ', ') .. '\n'
        end
    else
        message = 'No active LSP servers for buffer ' .. bufnr .. '.'
    end
    vim.notify(message, vim.log.levels.INFO)
end

vim.keymap.set('n', '<leader>ln', function()
    print_active_lsp_names(0)
end, { desc = 'Show LSP Names' })

vim.keymap.set('n', '<leader>li', function()
    print_detailed_lsp_info(0)
end, { desc = 'Show Detailed LSP Info' })
