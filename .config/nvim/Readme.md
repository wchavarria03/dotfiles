# Nvim

Neovim config explanation

What's supported

## Project Structure

This is the current file structure of the config
Which includes the following sections

```
~/.config/nvim/
├── after
│ └── ftplugin
│ └── json.vim
├── backupdir/
├── lua
│ ├── config
│ │ ├── autocommands.lua
│ │ ├── keymaps.lua
│ │ ├── lazy.lua
│ │ └── options.lua
│ ├── plugins
│ │ ├── ai
│ │ │ ├── Copilot.lua
│ │ │ └── copilot-chat.lua
│ │ ├── coding
│ │ │ ├── blink.lua
│ │ │ ├── lazydev.lua
│ │ │ ├── luasnip.lua
│ │ │ ├── mini-ai.lua
│ │ │ ├── mini-pairs.lua
│ │ │ ├── mini-surround.lua
│ │ │ ├── neogen.lua
│ │ │ ├── nvim-ts-context-commentstring.lua
│ │ │ ├── ts-comments.lua
│ │ │ └── yanky.lua
│ │ ├── editor
│ │ │ ├── flash.lua
│ │ │ ├── gitsigns.lua
│ │ │ ├── harpoon.lua
│ │ │ ├── inc-rename.lua
│ │ │ ├── neo-tree.lua
│ │ │ ├── todo-comments.lua
│ │ │ ├── trouble.lua
│ │ │ └── which-key.lua
│ │ ├── formatting
│ │ │ └── conform-nvim.lua
│ │ ├── languages
│ │ │ ├── markdown-preview-nvim.lua
│ │ │ ├── render-markdown-nvim.lua
│ │ │ └── schemastore.lua
│ │ ├── linting
│ │ │ └── nvim-lint.lua
│ │ ├── lsp
│ │ │ ├── mason.lua
│ │ │ └── nvim-lspconfig.lua
│ │ ├── snacks
│ │ │ ├── snacks-gitbrowser.lua
│ │ │ ├── snacks-notifier.lua
│ │ │ ├── snacks-nvim.lua
│ │ │ └── snacks-pickers.lua
│ │ ├── treesitter
│ │ │ ├── nvim-treesitter-objects.lua
│ │ │ ├── nvim-treesitter.lua
│ │ │ └── nvim-ts-autotag.lua
│ │ ├── ui
│ │ │ ├── bufferline.lua
│ │ │ ├── lualine.lua
│ │ │ ├── mini-icons.lua
│ │ │ └── noice.lua
│ │ ├── util
│ │ │ ├── cloak.lua
│ │ │ ├── persistence-nvim.lua
│ │ │ ├── plenary.lua
│ │ │ ├── twilight.lua
│ │ │ └── zen-mode.lua
│ │ ├── colorscheme.lua
│ │ └── colorscheme.lua2
├── spell/
├── init.lua
└── stylua.toml
```

### Sections/Folders

- **after/ftplugin**: Contains filetype-specific settings. For example, `json.vim` contains settings specific to JSON files.
- **backupdir**: Directory for backup files created by Neovim.
- **lua/config**: Contains general configuration files such as autocommands, key mappings, lazy loading settings and entry point, and options.
- **lua/plugins**: Contains configuration files for various plugins, organized into subdirectories based on their functionality:
  - **ai**: Plugins related to AI features (e.g., Copilot).
  - **coding**: Plugins that enhance coding experience (e.g., snippets, code commenting).
  - **editor**: Plugins that enhance the editor's functionality (e.g., file navigation, git integration).
  - **formatting**: Plugins for code formatting.
  - **languages**: Plugins for language-specific features (e.g., Markdown preview).
  - **linting**: Plugins for linting code.
  - **lsp**: Plugins for Language Server Protocol (LSP) support.
  - **snacks**: Miscellaneous plugins for additional features.
  - **treesitter**: Plugins related to Treesitter for better syntax highlighting and code understanding.
  - **ui**: Plugins that enhance the user interface (e.g., status line, icons).
  - **util**: Utility plugins for various enhancements (e.g., session management, file operations).
  - **colorscheme.lua**: Configuration for color schemes.
- **spell**: Directory for spell check files.
- **init.lua**: Main initialization file for Neovim configuration.
- **stylua.toml**: Configuration file for the StyLua formatter.

## Plugins

### ai

- **Copilot.lua**: Configuration for GitHub Copilot, an AI-powered code completion tool.
- **copilot-chat.lua**: Configuration for Copilot Chat, an AI-powered chat assistant for coding.

### coding

- **blink.lua**: Enhances the coding experience by providing visual cues for cursor movements and code completion.
- **lazydev.lua**: Tools and utilities for LUA development.
- **luasnip.lua**: Configuration for LuaSnip, a snippet engine for Neovim.
- **mini-ai.lua**: Provides text objects actions for motions .
- **mini-pairs.lua**: Automatically inserts matching pairs (e.g., brackets, quotes).
- **mini-surround.lua**: Easily add, delete, or change surrounding characters.
- **neogen.lua**: Generates documentation for code based on annotations.
- **nvim-ts-context-commentstring.lua**: Sets the comment string based on the cursor location in the code for treesitter.
- **ts-comments.lua**: Provides better commenting functionality using Treesitter.
- **yanky.lua**: Enhances the yank and paste functionality in Neovim.

### editor

Editor-related configurations and enhancements.

- **flash.lua**: Provides quick select, navigation, and find of test in a buffer.
- **gitsigns.lua**: Shows git changes in the sign column, plus other git related functionality.
- **harpoon.lua**: Quick file navigation and bookmarking.
- **inc-rename.lua**: Incremental renaming of variables and functions.
- **neo-tree.lua**: File explorer tree for Neovim.
- **todo-comments.lua**: Highlights and manages TODO comments in the code, highlighting and search.
- **trouble.lua**: A pretty list for showing diagnostics, references, TODOs, etc.
- **which-key.lua**: Displays available keybindings in a popup.

### formatting

- **conform-nvim.lua**: Configuration for code formatting tools.

### languages

Specific configurations for language-related features.

- **markdown-preview-nvim.lua**: Provides a live preview for Markdown files.
- **render-markdown-nvim.lua**: Renders Markdown files within Neovim.
- **schemastore.lua**: Provides JSON schemas for various file types.

### linting

- **nvim-lint.lua**: Configuration for linting tools in Neovim.

### lsp

Language Server Protocol (LSP) support for code intelligence and configuration.

- **mason.lua**: Manages LSP servers, DAP servers, linters, and formatters.
- **nvim-lspconfig.lua**: Configuration for Neovim's built-in LSP client.

### snacks

Multiple utilities including pickers, notifications, git functionalities, and miscellaneous Neovim utilities.

- **snacks-gitbrowser.lua**: Provides a git repository browser.
- **snacks-notifier.lua**: Notification system for various events.
- **snacks-nvim.lua**: Main snacks config file for enabling plugins without specific configs.
- **snacks-pickers.lua**: Provides various pickers for selecting items.

### treesitter

Syntax highlighting and code understanding using Treesitter.

- **nvim-treesitter-objects.lua**: Provides additional text objects using Treesitter.
- **nvim-treesitter.lua**: Configuration for Neovim Treesitter, which provides better syntax highlighting and code understanding.
- **nvim-ts-autotag.lua**: Automatically closes and renames HTML tags.

### ui

UI editor enhancements and configurations.

- **bufferline.lua**: Enhances the buffer line (tab line) in Neovim.
- **lualine.lua**: A blazing fast and easy to configure status line.
- **mini-icons.lua**: Provides icons for various UI elements.
- **noice.lua**: Enhances the Neovim UI with additional features mainly the CMD floating input.

### util

- **cloak.lua**: Hides sensitive information in the editor.
- **persistence-nvim.lua**: Manages session persistence.
- **plenary.lua**: Provides general utility functions for Neovim plugins.
- **twilight.lua**: Dims inactive portions of the code to focus on the active part.
- **zen-mode.lua**: Distraction-free coding mode.

### colorscheme.lua

- Configuration for color schemes.
