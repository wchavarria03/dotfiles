-----------------------------------------------------------
-- Neovim LSP configuration and Neovim LSP Installer
-----------------------------------------------------------

-- Plugin: mason
-- for language server setup see: https://github.com/williamboman/mason

return {
  {
    'williamboman/mason.nvim',
    cmd = "Mason",
    keys = { "<cmd>Mason<cr>" },
    build = ":MasonUpdate",
    config = true,
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    }
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      local lspconfig = require('lspconfig')
      local masonLspConfig = require("mason-lspconfig")

      masonLspConfig.setup {
        ensure_installed = {
          'bashls',
          'cssls',
          'cssmodules_ls',
          'ember',
          'eslint',
          'html',
          'jsonls',
          'lua_ls',
          'ruby_ls',
          'stylelint_lsp',
          'tsserver',
        }
      }

      ---
      -- LSP servers
      ---
      masonLspConfig.setup_handlers({
        function(server)
          -- See :help lspconfig-setup
          lspconfig[server].setup({})
        end,

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
    end,
    dependencies = {
      'williamboman/mason.nvim',
    }
  },
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    config = function()
      local lspconfig = require('lspconfig')

      local lsp_defaults = {
        flags = {
          debounce_text_changes = 150,
        },
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        on_attach = function(_, bufnr)
          local bufmap = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = 'LSP: ' .. desc })
          end

          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lua_omnifunc')

          -- You can search each function in the help page.
          -- For example :help vim.lsp.buf.hover()
          bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Declaration')
          bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', 'Definition')
          bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', 'Hover')
          bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Implementation')
          bufmap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', 'Add Workspace')
          bufmap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', 'Remove Workspace')
          bufmap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'List Workspaces')
          bufmap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Type Definition')
          bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', 'References')
          -- bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
          bufmap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename')
          bufmap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action')
          bufmap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', 'Line Diagnostics')

          bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', 'Range Action')
          bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', 'Diagnostic Modal')

          bufmap('n', '<leader>p', '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Prev')
          bufmap('n', '<leader>n', '<cmd>lua vim.diagnostic.goto_next()<cr>',  'Next')
          bufmap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', 'Telescope Diagostics')
        end
      }

      lspconfig.util.default_config = vim.tbl_deep_extend(
        'force',
        lspconfig.util.default_config,
        lsp_defaults
      )
    end,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  }
}
