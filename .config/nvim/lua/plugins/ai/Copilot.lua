return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = { 'InsertEnter', 'LspAttach' },
    opts = {
        -- DISABLED: Native Copilot UI is disabled to avoid conflicts with blink.cmp
        -- Copilot suggestions are handled through blink.cmp integration instead
        panel = {
            enabled = false, -- Keep disabled for unified completion experience
        },
        suggestion = {
            enabled = false, -- Keep disabled to prevent duplicate suggestions
        },
        filetypes = {
            yaml = true,
            markdown = true,
            help = true,
            gitcommit = true,
            gitrebase = true,
            ['.'] = false,
        },
        copilot_model = '', -- Use default model (GitHub automatically selects best available)
        server_opts_overrides = {
            trace = 'verbose',
            settings = {
                advanced = {
                    listCount = 10,
                    inlineSuggestCount = 3,
                },
            },
        },
    },
}
