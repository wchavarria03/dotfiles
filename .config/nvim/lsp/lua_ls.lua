return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        'selene.yml',
        '.git',
    },
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
    settings = {
        Lua = {
            completion = { callSnippet = 'Replace' },
            -- Using stylua for formatting.
            format = { enable = false },
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = 'Disable',
                semicolon = 'Disable',
                arrayIndex = 'Disable',
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                    [vim.fn.stdpath 'config' .. '/lua'] = true,
                    '${3rd}/luv/library',
                },
            },
        },
    },
}
