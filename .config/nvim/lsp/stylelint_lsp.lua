return {
    filetypes = { "css", "scss", "less" }, -- add more if needed
    settings = {
    stylelintplus = {
        -- You can specify a config file or use project/local config
        -- config = "/path/to/.stylelintrc",
        autoFixOnSave = true, -- set to true if you want auto-fix on save
        -- other stylelint-lsp options here
        },
    },
}