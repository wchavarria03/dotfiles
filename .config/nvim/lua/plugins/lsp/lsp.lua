local M = {}

M.plugins = {
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/j-hui/fidget.nvim',
}

function M.setup()
    require('fidget').setup {
        progress = {
            display = {
                progress_icon = { pattern = 'meter', period = 1 },
                progress_style = 'Comment',
                group_style = 'Title',
                icon_style = 'Question',
            },
        },
        notification = {
            window = { winblend = 0 },
        },
    }

    local utils = require 'plugins.lsp.utils'

    utils.set_lsp_capabilities()
    utils.set_diagnostic_config()

    vim.lsp.config('jsonls', {
        settings = {
            json = {
                schemas = require('schemastore').json.schemas(),
                validate = { enable = true },
            },
        },
    })

    vim.lsp.config('yamlls', {
        settings = {
            yaml = {
                schemas = require('schemastore').yaml.schemas(),
            },
        },
    })

    vim.lsp.config('lua_ls', {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
            },
        },
    })

    local function get_python_path()
        local cwd = vim.fn.getcwd()
        local venv_path = cwd .. '/.venv/bin/python'

        -- Check if .venv exists
        if vim.fn.filereadable(venv_path) == 1 then
            return venv_path
        end

        -- Fallback to system Python
        return vim.fn.exepath 'python3' or 'python'
    end

    vim.lsp.config('basedpyright', {
        before_init = function(_, config)
            config.settings.python.pythonPath = get_python_path()
        end,
        settings = {
            basedpyright = {
                analysis = {
                    typeCheckingMode = 'basic', -- or "standard" or "strict"
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = 'workspace',
                    autoImportCompletions = true,
                },
            },
            python = {
                pythonPath = vim.fn.getcwd() .. '/.venv/bin/python',
            },
        },
    })
end

return M
