return {
  "neovim/nvim-lspconfig",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = true,
      float = {
        header = false,
        border = "rounded",
        focusable = true,
      },
    },
    inlay_hints = {
      enabled = true,
    },
  },
  config = function(_, opts)
    -- Add rounded borders to the hover window
    local lspconfig = require("lspconfig")
    local blink = require("blink.cmp")
    vim.diagnostic.config(opts.diagnostics)

    -- KEYMAPS
    local lsp_opts = { noremap = true, silent = true }
    local on_attach = function(_, bufnr)
      lsp_opts.buffer = bufnr

      lsp_opts.desc = "Lsp Info"
      vim.keymap.set("n", "<leader>cl", function()
        require("snacks").picker.lsp_config()
      end, lsp_opts) -- show lsp info

      lsp_opts.desc = "Show References"
      vim.keymap.set("n", "gR", function()
        require("snacks").picker.lsp_references()
      end, lsp_opts) -- show definition, references

      lsp_opts.desc = "Go to Declaration"
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, lsp_opts) -- go to declaration

      lsp_opts.desc = "Go to Definition"
      vim.keymap.set("n", "gd", function()
        require("snacks").picker.lsp_definitions()
      end, lsp_opts) -- show lsp definitions

      lsp_opts.desc = "Go to Implementation"
      vim.keymap.set("n", "gi", function()
        require("snacks").picker.lsp_implementations()
      end, lsp_opts) -- show lsp implementations

      lsp_opts.desc = "Show LSP type definitions"
      vim.keymap.set("n", "gt", function()
        require("snacks").picker.lsp_type_definitions()
      end, lsp_opts) -- show lsp type definitions

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
      vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", lsp_opts) -- mapping to restart lsp if necessary
    end

    -- CAPABILITIES

    -- Extend servers capabilitites by joining default ones with blink capabilities
    local capabilities =
      vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), blink.get_lsp_capabilities())

    -- SERVERS
    local servers = {
      "bashls",
      "beancount",
      "golangci_lint_ls",
      "dockerls",
      "docker_compose_language_service",
      "gopls",
      "jsonls",
      "lua_ls",
      "marksman",
      "pyright",
      "ruby_lsp",
      "ts_ls",
    }

    local server_special_configs = {
      beancount = {
        root_dir = lspconfig.util.root_pattern("beanfile", ".git"),
        settings = {
          init_options = {
            journalFile = "~/personal/finances/main.beancount",
          },
          beancount = {
            journalFile = "~/personal/finances/main.beancount",
          },
        },
        -- cmd = { "/usr/local/bin/beancount-language-server" },
        capabilities = vim.deepcopy(capabilities),
        on_attach = on_attach,
      },
      gopls = {
        settings = {
          gopls = {
            gofumpt = true,
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
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
          },
        },
        capabilities = vim.deepcopy(capabilities),
        on_attach = on_attach,
      },
      jsonls = {
        settings = {
          json = {
            format = {
              enable = true,
            },
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
        capabilities = vim.deepcopy(capabilities),
        on_attach = on_attach,
      },
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
        capabilities = vim.deepcopy(capabilities),
        on_attach = on_attach,
      },
      ts_ls = {
        settings = {
          completions = {
            completeFunctionCalls = true,
          },
        },
        capabilities = vim.deepcopy(capabilities),
        on_attach = on_attach,
      },

      golangcilsp = {
        default_config = {
          init_options = {
            command = {
              "golangci-lint",
              "run",
              "--output.json.path",
              "stdout",
              "--show-stats=false",
              "--issues-exit-code=1",
            },
          },
        },
      },
    }

    local default_config = {
      capabilities = vim.deepcopy(capabilities),
      on_attach = on_attach,
    }

    for _, lsp in ipairs(servers) do
      local config = server_special_configs[lsp] or default_config
      lspconfig[lsp].setup(config)
    end
  end,
}
