# Neovim Configuration

A well-organized Neovim configuration focused on productivity, with special emphasis on note-taking and markdown workflows.

## Features

- **Organized Structure**: Clean, modular configuration that's easy to maintain and extend
- **Smart Keymaps**: Intuitive keybindings organized by functionality
- **Plugin Management**: Native vim.pack for efficient plugin loading
- **LSP Support**: Full language server protocol support for code intelligence
- **Modern UI**: Enhanced user interface with status lines, icons, and visual improvements

## Project Structure

```
~/.config/nvim/
├── after/
│   └── ftplugin/
│       └── json.vim
├── backupdir/
├── lua/
│   ├── core/                    # Core Neovim setup
│   │   ├── options.lua         # Neovim options
│   │   ├── keymaps.lua         # Global keymaps
│   │   ├── autocommands.lua    # Global autocommands
│   │   ├── lazy.lua            # Plugin manager setup
│   │   └── lsp.lua             # LSP configuration
│   │
│   ├── utils/                   # Utility functions
│   │   ├── init.lua            # Utils module initialization
│   │   ├── colorschema-overrides.lua
│   │   └── lualine_components.lua
│   │
│   ├── config/                  # Legacy configurations
│   │   └── prompts /            # Pormpts configs
│   │
│   └── plugins/                 # Plugin configurations
│       ├── ai/                 # AI plugin
│       ├── coding/             # Coding enhancements
│       ├── editor/             # Editor plugins
│       ├── formatting/         # Code formatting
│       ├── languages/          # Language-specific features
│       ├── linting/            # Code linting
│       ├── lsp/                # LSP configurations
│       ├── treesitter/         # Syntax highlighting
│       ├── ui/                 # User interface
│       └── util/               # Utility plugins
├── spell/
├── init.lua                     # Main entry point
└── stylua.toml
```

### Directory Explanations

- **core/**: Essential Neovim configuration (options, keymaps, autocommands)
- **utils/**: Reusable utility functions and helpers
- **plugins/**: Plugin configurations organized by functionality
- **config/**: Legacy directory (only contains prompts configs)
- **after/**: Filetype-specific settings that load after plugins

## Global Keymaps

### Leader Key

The leader key is set to `,` (comma).

### Navigation

- `<leader>h/j/k/l` - Navigate between windows
- `<leader>f` - Find files
- `<leader>g` - Git operations
- `<leader>s` - Search operations

### Buffer Management

- `<leader>b` - Buffer operations
- `<leader>w` - Window operations

### LSP

- `gd` - Go to definition
- `gr` - Go to references
- `K` - Show hover documentation
- `<leader>ca` - Code actions
- `<leader>cR` - Rename symbol

## Plugins

### Core Plugins

- **vim.pack** - Native plugin manager
- **Which-key** - Keybinding discovery
- **Snacks.nvim** - Picker and utilities
- **Treesitter** - Syntax highlighting

### Markdown

- **Markdown Preview** - Live markdown preview
- **Todo Comments** - Highlight and manage TODOs

### Development

- **LSP** - Language server protocol support
- **Mason** - LSP server management
- **Conform** - Code formatting
- **Lint** - Code linting

### UI Enhancements

- **Lualine** - Status line
- **Mini Icons** - Icons throughout the UI
- **Noice** - Enhanced command line

## Installation

1. Clone this repository to `~/.config/nvim/`
2. Install Neovim (version 0.9+ recommended)
3. Start Neovim and wait for plugins to install
4. Configure your preferred settings

## Configuration

### Customization

- Edit `lua/core/options.lua` for Neovim options
- Edit `lua/core/keymaps.lua` for global keymaps

### Adding New Features

- **Utilities**: Add to `lua/utils/`
- **Plugins**: Add to `lua/plugins/`

## LSP Setup

The configuration includes comprehensive LSP support through Mason and nvim-lspconfig.

![Mason/Nvim Setup Screenshot](images/nvim-mason-setup.png)

## Contributing

This configuration is designed to be modular and extensible. Feel free to:

- Add new utility functions to `utils/`
- Enhance existing functionality
- Submit improvements and bug fixes

## License

This configuration is provided as-is for personal use and learning.

Notes live in Emacs (org-roam) now; see `.config/doom/org-config.el`.
