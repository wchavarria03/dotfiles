return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl', 'gosum' },
  root_markers = {
    "go.mod",
    "go.sum",
  },
  single_file_support = true,
  settings = {
    gopls = {
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      semanticTokens = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
    },
  },
  -- root_dir = function(fname)
  --   -- see: https://github.com/neovim/nvim-lspconfig/issues/804
  --   if not mod_cache then
  --     local result = async.run_command { 'go', 'env', 'GOMODCACHE' }
  --     if result and result[1] then
  --       mod_cache = vim.trim(result[1])
  --     else
  --       mod_cache = vim.fn.system 'go env GOMODCACHE'
  --     end
  --   end
  --   if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
  --     local clients = util.get_lsp_clients { name = 'gopls' }
  --     if #clients > 0 then
  --       return clients[#clients].config.root_dir
  --     end
  --   end
  --   return util.root_pattern('go.work', 'go.mod', '.git')(fname)
  -- end,
}
