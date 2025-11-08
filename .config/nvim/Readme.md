# Neovim Configuration

A well-organized Neovim configuration focused on productivity, with special emphasis on note-taking and markdown workflows.

## Features

- **Organized Structure**: Clean, modular configuration that's easy to maintain and extend
- **Notes Mode**: Dedicated mode for note-taking with comprehensive markdown support
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
│   │   ├── notes.lua           # Notes/markdown utility functions
│   │   ├── colorschema-overrides.lua
│   │   └── lualine_components.lua
│   │
│   ├── modes/                   # Mode-specific configurations
│   │   ├── init.lua            # Modes module initialization
│   │   └── notes.lua           # Notes mode configuration
│   │
│   ├── config/                  # Legacy configurations
│   │   └── prompts /            # Pormpts configs
│   │
│   └── plugins/                 # Plugin configurations
│       ├── ai/                 # AI plugins (Copilot, etc.)
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
- **modes/**: Mode-specific configurations (notes mode, coding mode, etc.)
- **plugins/**: Plugin configurations organized by functionality
- **config/**: Legacy directory (only contains prompts configs)
- **after/**: Filetype-specific settings that load after plugins

## Notes Workflow

This configuration includes a comprehensive notes mode designed for efficient markdown note-taking.

### Enabling Notes Mode

Set the environment variable to enable notes mode:

```bash
export NVIM_MODE=notes
```

Or set it in your shell profile for permanent activation.

### Notes Keymaps

All notes keymaps use the `<leader>n` prefix and are organized in which-key for easy discovery.

#### Text Formatting

- `<leader>nb` - **Bold text** (`**text**`)
- `<leader>ni` - _Italic text_ (`*text*`)
- `<leader>ns` - ~~Strikethrough~~ (`~~text~~`)
- `<leader>na` - [Link](url) (`[text](url)`)

#### Headers

- `<leader>nh1` - Header 1 (`# Header`)
- `<leader>nh2` - Header 2 (`## Header`)
- `<leader>nh3` - Header 3 (`### Header`)
- `<leader>nh4` - Header 4 (`#### Header`)

#### Lists

- `<leader>nl` - Unordered list (`- item`)
- `<leader>n1` - Ordered list (`1. item`)

#### Todo Items

- `<leader>ntt` - Add/toggle todo item (`- [ ] item`)
- `<leader>ntd` - Add/toggle done item (`- [x] item`)

#### Code

- `<leader>ncb` - Code block (```)
- `<leader>nci` - Inline code (`)
- `<leader>nk` - Inline code (alternative)

#### Other

- `<leader>nq` - Quote block (`> quote`)
- `<leader>nhr` - Horizontal rule (`---`)
- `<leader>no` - Open notes folder
- `<leader>nz` - Toggle zen mode

### Visual Mode Formatting

Select text and use these keymaps to wrap it with markdown formatting:

- `<leader>nb` - Wrap with bold (`**selected**`)
- `<leader>ni` - Wrap with italic (`*selected*`)
- `<leader>nk` - Wrap with code (`` `selected` ``)
- `<leader>ns` - Wrap with strikethrough (`~~selected~~`)

### Smart Features

- **Smart Checkboxes**: Todo keymaps automatically detect existing checkboxes and toggle them, or add new ones at the start of the line
- **Preserved Indentation**: All formatting preserves existing indentation levels
- **Which-key Integration**: All keymaps are discoverable through which-key

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

### Notes & Markdown

- **Markdown Preview** - Live markdown preview
- **Zen Mode** - Distraction-free writing
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
- Edit `lua/utils/notes.lua` for notes functionality
- Edit `lua/modes/notes.lua` for notes mode settings

### Adding New Features

- **Utilities**: Add to `lua/utils/`
- **Modes**: Add to `lua/modes/`
- **Plugins**: Add to `lua/plugins/`

## LSP Setup

The configuration includes comprehensive LSP support through Mason and nvim-lspconfig.

![Mason/Nvim Setup Screenshot](images/nvim-mason-setup.png)

## Contributing

This configuration is designed to be modular and extensible. Feel free to:

- Add new utility functions to `utils/`
- Create new modes in `modes/`
- Enhance existing functionality
- Submit improvements and bug fixes

## License

This configuration is provided as-is for personal use and learning.

