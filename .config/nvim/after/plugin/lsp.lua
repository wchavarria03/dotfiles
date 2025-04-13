if vim.g.vscode then
    return
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local lsp_opts = { noremap = true, silent = true, buffer = event.buf }

    lsp_opts.desc = "Lsp Info"
    vim.keymap.set("n", "<leader>cl", function()
      require("snacks").picker.lsp_config()
    end, lsp_opts) -- show lsp info

    lsp_opts.desc = "Show References"
    vim.keymap.set("n", "gR", function()
      require("snacks").picker.lsp_references()
    end, lsp_opts)

    lsp_opts.desc = "Go to Declaration"
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, lsp_opts) -- go to declaration

    lsp_opts.desc = "Go to Definition"
    vim.keymap.set("n", "gd", function()
      require("snacks").picker.lsp_definitions()
    end, lsp_opts)

    lsp_opts.desc = "Go to Implementation"
    vim.keymap.set("n", "gi", function()
      require("snacks").picker.lsp_implementations()
    end, lsp_opts)

    lsp_opts.desc = "Show LSP type definitions"
    vim.keymap.set("n", "gt", function()
      require("snacks").picker.lsp_type_definitions()
    end, lsp_opts)

    lsp_opts.desc = "Code Actions"
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, lsp_opts) -- see available code actions, in visual mode will apply to selection

    lsp_opts.desc = "Smart rename"
    vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, lsp_opts) -- smart rename

    lsp_opts.desc = "Line diagnostics"
    vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, lsp_opts) -- show diagnostics for line

    lsp_opts.desc = "Go to previous diagnostic"
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, lsp_opts) -- jump to previous diagnostic in buffer

    lsp_opts.desc = "Go to next diagnostic"
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, lsp_opts) -- jump to next diagnostic in buffer

    lsp_opts.desc = "Show documentation for what is under cursor"
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({
        border = "single",
        offset_x = 10,
        offset_y = 10,
      })
    end, lsp_opts) -- show documentation for what is under cursor

    lsp_opts.desc = "Run Codelens"
    vim.keymap.set({ "n", "v" }, "<leader>cc", function()
      vim.lsp.codelens.run()
    end, lsp_opts)

    lsp_opts.desc = "Refresh & Display Codelens"
    vim.keymap.set("n", "<leader>cC", function()
      vim.lsp.codelens.refresh()
    end, lsp_opts)

    lsp_opts.desc = "Restart LSP"
    vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", lsp_opts) -- mapping to restart lsp if necessary
  end
})

vim.lsp.config('*', {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
  root_markers = { '.git' },
})

vim.lsp.enable("bash_ls")
vim.lsp.enable("beancount_ls")
vim.lsp.enable("docker_compose_ls")
vim.lsp.enable("docker_ls")
vim.lsp.enable("golangci_lint_ls")
vim.lsp.enable("gopls")
vim.lsp.enable("json_ls")
vim.lsp.enable("lua_ls")

local function get_active_lsp_names(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  return names
end

local function print_active_lsp_names(bufnr)
  local names = get_active_lsp_names(bufnr)
  local message = ""
  if #names > 0 then
    message = "Active LSP servers for buffer " .. bufnr .. ":\n"
    for _, name in ipairs(names) do
      message = message .. "- " .. name .. "\n"
    end
  else
    message = "No active LSP servers for buffer " .. bufnr .. "."
  end
  vim.notify(message, vim.log.levels.INFO)
end

local function print_detailed_lsp_info(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local message = ""
  if #clients > 0 then
    message = "Active LSP servers for buffer " .. bufnr .. ":\n"
    for _, client in ipairs(clients) do
      message = message .. "--------------------\n"
      message = message .. "Name: " .. client.name .. "\n"
      message = message .. "ID: " .. client.id .. "\n"
      message = message .. "Capabilities:\n"
      for capability, enabled in pairs(client.capabilities) do
        if enabled then
          message = message .. "  - " .. capability .. "\n"
        end
      end
      message = message .. "Attached Filetypes: " .. table.concat(client.config.filetypes or {}, ", ") .. "\n"
    end
  else
    message = "No active LSP servers for buffer " .. bufnr .. "."
  end
  vim.notify(message, vim.log.levels.INFO)
end


vim.keymap.set('n', '<leader>ln', function()
  print_active_lsp_names(0)
end, { desc = 'Show LSP Names' })

vim.keymap.set('n', '<leader>li', function()
  print_detailed_lsp_info(0)
end, { desc = 'Show Detailed LSP Info' })
