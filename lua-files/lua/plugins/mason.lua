-----------------------------------------------------------
-- Neovim LSP configuration and Neovim LSP Installer
-----------------------------------------------------------

-- Plugin: mason
-- for language server setup see: https://github.com/williamboman/mason

local mason = require("mason")
local lspconfig = require('lspconfig')
local masonLspConfig = require("mason-lspconfig")

local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  -- capabilities = require('cmp_nvim_lsp').update_capabilities(
  --  vim.lsp.protocol.make_client_capabilities()
  -- ),
  on_attach = function(client, bufnr)
    local bufmap = function(mode, lhs, rhs)
      local opts = {noremap = true, silent = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- vim.option.set('omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lua_omnifunc')


    -- You can search each function in the help page.
    -- For example :help vim.lsp.buf.hover()
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    bufmap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    bufmap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
    bufmap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    -- bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    bufmap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    bufmap('n', '<leader>p', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    bufmap('n', '<leader>n', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    bufmap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>')
  end
}

lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  lsp_defaults
)

--------------
--------------
--------------
--------------

---
-- LSP Keybindings
---
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Include the servers you want to have installed by default below
masonLspConfig.setup {
  ensure_installed = {
    "html",
    "jsonls",
    "lua_ls",
    "tsserver",
    "bashls",
    "cssls",
    "cssmodules_ls",
    "stylelint_lsp",
    "ember",
    "eslint",
  }
}

---
-- LSP servers
---
local default_handler = function(server)
  -- See :help lspconfig-setup
  lspconfig[server].setup({})
end

masonLspConfig.setup_handlers({
  default_handler,
  ['tsserver'] = function()
    lspconfig.tsserver.setup({
      settings = {
        completions = {
          completeFunctionCalls = true
        }
      }
    })
  end,
  ["lua_ls"] = function ()
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "use", "group" }
          }
        }
      }
    }
   end,
})
