-----------------------------------------------------------lsplsp
-- Neovim LSP configuration and Neovim LSP Installer
-----------------------------------------------------------

-- Plugin: mason
-- for language server setup see: https://github.com/williamboman/mason

local utils = require "core.utils"
local merge_tb = vim.tbl_deep_extend

return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    config = true,
    opts = {
      ui = {
        border = 'single',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗'
        }
      }
    }
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufEnter', 'BufReadPost', 'BufNewFile' },
    config = function()
      local lspconfig = require('lspconfig')
      local masonLspConfig = require('mason-lspconfig')

      local servers_to_install = {
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

      local handlers = {
        -- Default handler for most of the servers
        function(server)
          lspconfig[server].setup {}
        end,

        -- Override tsserver with this handler
        ['tsserver'] = function()
          lspconfig.tsserver.setup({
            settings = {
              completions = {
                completeFunctionCalls = true
              }
            }
          })
        end,
        ['lua_ls'] = function ()
          lspconfig.lua_ls.setup {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim', 'use', 'group' }
                }
              }
            }
          }
        end,
      }

      masonLspConfig.setup({
        handlers = handlers,
        ensure_installed  = servers_to_install
      })
    end,
    dependencies = {
      'williamboman/mason.nvim',
    }
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
    config = function()
      local lspconfig = require('lspconfig')
      local lsp_defaults = lspconfig.util.default_config

      local lsp_custom_capabilities = merge_tb(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      local lsp_custom_config = {
        flags = {
          debounce_text_changes = 150,
        },
        capabilities = lsp_custom_capabilities,
        on_attach = function(_, bufnr)
          local opts = { noremap = true, silent = true, buffer=bufnr }

          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- You can search each function in the help page.
          -- For example :help vim.lsp.buf.hover()
          utils.mapKey('LSP', 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', merge_tb('force', opts, { desc = 'Declaration' }))
          utils.mapKey('LSP', 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', merge_tb('force', opts, { desc = 'Definition' }))
          utils.mapKey('LSP', 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', merge_tb('force', opts, { desc = 'Hover' }))
          utils.mapKey('LSP', 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', merge_tb('force', opts, { desc = 'Implementation' }))
          utils.mapKey('LSP', 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', merge_tb('force', opts, { desc = 'Add Workspace' }))
          utils.mapKey('LSP', 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', merge_tb('force', opts, { desc = 'Remove Workspace' }))
          utils.mapKey('LSP', 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', merge_tb('force', opts, { desc = 'List Workspaces' }))
          utils.mapKey('LSP', 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', merge_tb('force', opts, { desc = 'Type Definition' }))
          utils.mapKey('LSP', 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', merge_tb('force', opts, { desc = 'References' }))
          utils.mapKey('LSP', 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', merge_tb('force', opts, { desc = 'Signature' }))
          utils.mapKey('LSP', 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', merge_tb('force', opts, { desc = 'Rename' }))
          utils.mapKey('LSP', 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', merge_tb('force', opts, { desc = 'Code Action' }))
          utils.mapKey('LSP', 'n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', merge_tb('force', opts, { desc = 'Line Diagnostics' }))

          utils.mapKey('LSP', 'x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', merge_tb('force', opts, { desc = 'Range Action' }))
          utils.mapKey('LSP', 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', merge_tb('force', opts, { desc = 'Diagnostic Modal' }))

          utils.mapKey('LSP', 'n', '<leader>p', '<cmd>lua vim.diagnostic.goto_prev()<cr>', merge_tb('force', opts, { desc = 'Prev' }))
          utils.mapKey('LSP', 'n', '<leader>n', '<cmd>lua vim.diagnostic.goto_next()<cr>', merge_tb('force', opts, { desc =  'Next' }))
          utils.mapKey('LSP', 'n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', merge_tb('force', opts, { desc = 'Telescope Diagostics' }))
        end
      }

      lspconfig.util.default_config = vim.tbl_deep_extend(
        'force',
        lsp_defaults,
        lsp_custom_config
      )
    end,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp'
    },
  }
}
