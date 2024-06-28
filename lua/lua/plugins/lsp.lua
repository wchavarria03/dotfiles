-----------------------------------------------------------lsplsp
-- Neovim LSP configuration and Neovim LSP Installer
-----------------------------------------------------------
local utils = require 'core.utils'
local merge_tb = vim.tbl_deep_extend

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
    config = function()
      local lspconfig = require 'lspconfig'
      local lsp_defaults = lspconfig.util.default_config

      local border = {
        { '╭', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '╮', 'FloatBorder' },
        { '│', 'FloatBorder' },
        { '╯', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '╰', 'FloatBorder' },
        { '│', 'FloatBorder' },
      }
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      local lsp_custom_config = {
        flags = {
          debounce_text_changes = 1000,
        },
      }

      require('lspconfig.ui.windows').default_options.border = 'single'
      lspconfig.util.default_config = vim.tbl_deep_extend('force', lsp_defaults, lsp_custom_config)

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.api.nvim_buf_set_option(event.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          utils.mapKey('LSP', 'n', 'gD', vim.lsp.buf.declaration, merge_tb('force', opts, { desc = '[G]o [D]eclaration' }))
          utils.mapKey('LSP', 'n', 'gd', require('telescope.builtin').lsp_definitions, merge_tb('force', opts, { desc = '[G]o [D]efinition' }))
          utils.mapKey('LSP', 'n', 'gi', require('telescope.builtin').lsp_implementations, merge_tb('force', opts, { desc = '[G]o [I]mplementation' }))
          utils.mapKey('LSP', 'n', 'gr', require('telescope.builtin').lsp_references, merge_tb('force', opts, { desc = '[G]o [R]eferences' }))
          utils.mapKey('LSP', 'n', 'K', vim.lsp.buf.hover, merge_tb('force', opts, { desc = 'Hover' }))

          -- TODO: Pending to learn how to use the workspace
          utils.mapKey('LSP', 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', merge_tb('force', opts, { desc = 'Add Workspace' }))
          utils.mapKey('LSP', 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', merge_tb('force', opts, { desc = 'Remove Workspace' }))
          utils.mapKey(
            'LSP',
            'n',
            '<leader>wl',
            '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
            merge_tb('force', opts, { desc = 'List Workspaces' })
          )

          utils.mapKey('LSP', 'n', '<leader>D', require('telescope.builtin').lsp_type_definitions, merge_tb('force', opts, { desc = '[T]ype [D]efinition' }))
          utils.mapKey('LSP', 'n', '<C-d>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', merge_tb('force', opts, { desc = 'Signature' }))
          utils.mapKey('LSP', 'n', '<leader>ca', vim.lsp.buf.code_action, merge_tb('force', opts, { desc = '[C]ode [A]ction' }))
          utils.mapKey('LSP', 'x', '<leader>cA', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', merge_tb('force', opts, { desc = 'Range Action' }))
          utils.mapKey('LSP', 'n', '<leader>cr', vim.lsp.buf.rename, merge_tb('force', opts, { desc = '[R]e[n]ame' }))

          utils.mapKey('LSP', 'n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<cr>', merge_tb('force', opts, { desc = 'Diagnostic Modal' }))
          utils.mapKey('LSP', 'n', '<leader>dl', '<cmd>Telescope diagnostics<CR>', merge_tb('force', opts, { desc = 'Telescope Diagnostics' }))

          utils.mapKey('LSP', 'n', '<leader>k', '<cmd>lua vim.diagnostic.goto_prev()<cr>', merge_tb('force', opts, { desc = 'Prev' }))
          utils.mapKey('LSP', 'n', '<leader>j', '<cmd>lua vim.diagnostic.goto_next()<cr>', merge_tb('force', opts, { desc = 'Next' }))

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          utils.mapKey('LSP', 'n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, merge_tb('force', opts, { desc = '[D]ocument [S]ymbols' }))

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          utils.mapKey(
            'LSP',
            'n',
            '<leader>ws',
            require('telescope.builtin').lsp_dynamic_workspace_symbols,
            merge_tb('force', opts, { desc = '[W]orkspace [S]ymbols' })
          )

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            utils.mapKey('LSP', 'n', '<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, merge_tb('force', opts, { desc = '[T]oggle Inlay [H]ints' }))
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        tsserver = {
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim', 'use', 'group' },
              },
            },
          },
        },
        eslint = {
          settings = {
            validate = 'on',
            packageManager = 'npm',
            codeActionOnSave = {
              enable = true,
              mode = 'all',
            },
            format = true,
            autoFixOnSave = true,
          },
        },
        gopls = {
          settings = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
              staticcheck = true,
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})

      vim.list_extend(ensure_installed, {
        'bashls',
        'cssls',
        'gopls',
        'html',
        'jsonls',
        'stylelint_lsp',
        -- "ruby_ls",

        -- Dbugger adapter
        'chrome-debug-adapter',
        'delve',
        'js-debug-adapter',

        -- Formatters
        'stylua',
        'gofumpt',
        'goimports-reviser',
        'golines',
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = true,
        opts = {
          ui = {
            border = 'single',
            icons = {
              package_installed = '✓',
              package_pending = '➜',
              package_uninstalled = '✗',
            },
          },
        },
      },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'folke/lazydev.nvim',
    },
  },
}
