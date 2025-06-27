# VS Code Neovim Configuration

A clean, minimal Neovim configuration specifically designed for use with the [VS Code Neovim plugin](https://github.com/vscode-neovim/vscode-neovim).

## 🎯 Purpose

This configuration provides Neovim's powerful editing capabilities while leveraging VS Code's excellent UI and built-in features. It's optimized for the VS Code Neovim plugin and removes all redundant functionality that VS Code already provides.

## 📁 Project Structure

```
~/.config/nvim-cursor/
├── init.lua                    # Main entry point
├── lua/
│   ├── config/
│   │   ├── options.lua         # Essential Neovim options
│   │   ├── keymaps.lua         # Keymaps with VS Code integration
│   │   └── autocommands.lua    # Essential autocommands
│   ├── core/
│   │   └── lazy.lua           # Plugin manager configuration
│   └── plugins/
│       ├── coding/            # Coding enhancements
│       ├── formatting/        # Code formatting
│       └── linting/          # Code linting
└── Readme.md
```

## 🚀 Features

### ✅ VS Code Integration
- **Native VS Code commands** - All navigation uses `VSCodeNotify()` for seamless integration
- **Window management** - Uses VS Code's native window resize commands
- **File operations** - Leverages VS Code's explorer, quick open, and search
- **LSP integration** - Uses VS Code's built-in LSP features
- **UI access** - Direct access to VS Code's command palette, settings, terminal, etc.

### ✅ Enhanced Editing
- **Smart navigation** - Enhanced j/k with gj/gk for wrapped lines
- **Improved search** - Centered search results with n/N
- **Better scrolling** - Centered scrolling with Ctrl+d/u
- **Selection preservation** - Keep selection after indenting
- **Auto-pairing** - Smart bracket and quote pairing
- **Surround operations** - Easy text surrounding
- **Snippets** - Code snippet support
- **Text objects** - Enhanced text object operations

### ✅ Code Quality
- **Formatting** - Automatic code formatting with conform.nvim
- **Linting** - Code linting with nvim-lint
- **Spell checking** - Built-in spell checking support

## ⌨️ Keymaps

### Navigation
| Key | Action |
|-----|--------|
| `j/k` | Enhanced navigation (gj/gk for wrapped lines) |
| `n/N` | Next/previous search result (centered) |
| `gh` | Show hover |
| `gd` | Go to definition |
| `gD` | Peek definition |
| `gf` | Go to declaration |
| `gF` | Peek declaration |
| `gH` | Find references |
| `gO` | Go to symbol |

### VS Code Integration
| Key | Action |
|-----|--------|
| `<leader>e` | Explorer |
| `<leader>f` | Quick open |
| `<leader>F` | Find in files |
| `<leader>s` | Go to symbol |
| `<leader>S` | Show all symbols |
| `<leader>p` | Command palette |
| `<leader>,` | Open settings |
| `<leader>k` | Open keybindings |
| `<leader>t` | Toggle terminal |
| `<leader>T` | New terminal |
| `<leader>d` | Problems panel |
| `<leader>g` | Source control |
| `<leader>x` | Extensions |
| `<leader>w` | Recent files |
| `<leader>h` | Show all editors |

### Window Management
| Key | Action |
|-----|--------|
| `<C-w>gd` | Go to definition aside |
| `<C-w>gf` | Go to declaration aside |
| `<C-w>>` | Increase window size |
| `<C-w><` | Decrease window size |
| `<C-w>+` | Increase window size |
| `<C-w>-` | Decrease window size |

### Editing
| Key | Action |
|-----|--------|
| `jk` | Escape (insert mode) |
| `<C-c>` | Escape (insert mode) |
| `<Esc>` | Clear search highlighting |
| `=` | Format selection |
| `<C-d>/<C-u>` | Enhanced scrolling (centered) |
| `<`/`>` | Indent with selection preservation |

### Plugin-Specific Keymaps
| Key | Action |
|-----|--------|
| `<leader>y` | Open Yank History (Yanky) |
| `<leader>cn` | Generate Code Annotations (Neogen) |
| `<leader>cF` | Format Injected Languages (Conform) |

### Advanced Yank Operations (Yanky)
| Key | Action |
|-----|--------|
| `y` | Enhanced yank with highlighting |
| `p/P` | Enhanced put after/before |
| `gp/gP` | Enhanced put after/before (linewise) |
| `[y/]y` | Cycle through yank history |
| `[p/]p` | Put with indentation |
| `>p/<p` | Put with shift right/left |
| `=p/=P` | Put with filter |

## 🔧 Configuration

### Options (`lua/config/options.lua`)
Essential Neovim options optimized for VS Code Neovim:
- Line numbers and relative numbers
- Indentation settings
- Search configuration
- Display settings
- Clipboard integration
- Performance optimizations

### Keymaps (`lua/config/keymaps.lua`)
All keymaps use VS Code's native commands via `VSCodeNotify()` for seamless integration.

### Autocommands (`lua/config/autocommands.lua`)
Essential autocommands for:
- Highlight on yank
- Filetype-specific settings
- Buffer management

## 📦 Plugins

### Essential Plugins Only
- **`coding/`** - Coding enhancements (pairs, surround, ai, snippets, yanky, neogen)
- **`formatting/`** - Code formatting (conform.nvim)
- **`linting/`** - Code linting (nvim-lint)

### Removed Plugins
The following plugins were intentionally removed as they duplicate VS Code functionality:
- ❌ UI plugins (statusline, bufferline, etc.) - VS Code handles UI
- ❌ File explorers (neo-tree, etc.) - VS Code has explorer
- ❌ Git integration (gitsigns, etc.) - VS Code has git
- ❌ LSP management (mason, etc.) - VS Code handles LSP
- ❌ Syntax highlighting (treesitter, etc.) - VS Code handles syntax
- ❌ Search plugins (flash, etc.) - VS Code has search
- ❌ Utility plugins (zen-mode, etc.) - VS Code has zen mode
- ❌ Completion plugins (blink, etc.) - VS Code has IntelliSense
- ❌ Comment plugins (ts-comments, etc.) - VS Code has commenting
- ❌ Undo tree plugins (undotree, etc.) - VS Code has undo history

## 🚀 Installation

1. **Install VS Code Neovim plugin**
   ```bash
   # In VS Code, install the extension:
   # asvetliakov.vscode-neovim
   ```

2. **Install Neovim**
   ```bash
   # macOS
   brew install neovim
   
   # Ubuntu/Debian
   sudo apt install neovim
   
   # Windows
   # Download from https://github.com/neovim/neovim/releases
   ```

3. **Clone this configuration**
   ```bash
   git clone <your-repo> ~/.config/nvim-cursor
   ```

4. **Configure VS Code**
   Add to your VS Code settings:
   ```json
   {
     "vscode-neovim.useWSL": false,
     "vscode-neovim.neovimInitVim": "~/.config/nvim-cursor/init.lua"
   }
   ```

5. **Recommended VS Code Extensions**
   For enhanced functionality equivalent to removed Neovim plugins:
   ```json
   {
     "extensions": [
       "ms-vscode.vscode-json",
       "bradlc.vscode-tailwindcss",
       "esbenp.prettier-vscode",
       "ms-python.python",
       "ms-vscode.vscode-typescript-next",
       "ms-vscode.vscode-js-debug",
       "ms-vscode.vscode-js-debug-companion",
       "ms-vscode.vscode-eslint",
       "ms-vscode.vscode-prettier",
       "ms-vscode.vscode-json-language-features",
       "ms-vscode.vscode-typescript-language-features"
     ]
   }
   ```

## 🎯 Benefits

### ✅ Advantages
- **Zero conflicts** with VS Code features
- **Fast startup** - Minimal plugin loading
- **Native feel** - Uses VS Code's UI and features
- **Powerful editing** - Neovim's editing capabilities
- **Clean code** - Easy to maintain and customize
- **Production ready** - Stable and reliable

### 🚫 What's Not Included
- Terminal-specific features (VS Code handles terminal)
- UI customization (VS Code handles UI)
- File management (VS Code handles file operations)
- Git integration (VS Code handles git)
- LSP management (VS Code handles LSP)
- Syntax highlighting (VS Code handles syntax)

## 🔄 Updates

This configuration is designed to be minimal and stable. Updates focus on:
- Bug fixes
- VS Code Neovim compatibility improvements
- Essential plugin updates
- Performance optimizations

## 🤝 Contributing

This configuration is specifically designed for VS Code Neovim. When contributing:
- Ensure compatibility with VS Code Neovim plugin
- Avoid adding features that duplicate VS Code functionality
- Keep the configuration minimal and focused
- Test thoroughly with VS Code Neovim

## 📄 License

This configuration is provided as-is for use with VS Code Neovim.

## 🙏 Credits

- [VS Code Neovim](https://github.com/vscode-neovim/vscode-neovim) - The amazing VS Code extension
- [Lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- All the plugin authors whose work makes this configuration possible
