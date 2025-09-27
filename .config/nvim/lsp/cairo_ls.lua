return {
    init_options = { hostInfo = 'neovim' },
    cmd = { 'scarb-cairo-language-server', '/C', '--node-ipc' },
    filetypes = { 'cairo' },
    root_markers = { 'Scarb.toml', 'cairo_project.toml', '.git' },
}
