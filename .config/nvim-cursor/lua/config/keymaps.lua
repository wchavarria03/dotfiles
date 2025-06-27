-- Enhanced navigation
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Escape mappings
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Escape' })
vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Escape' })

-- Clear search highlighting
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', { desc = 'Clear Search', silent = true })

-- Enhanced search navigation
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next Search Result', noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous Search Result', noremap = true, silent = true })

-- Enhanced scrolling
vim.keymap.set('v', '<C-d>', '<C-d>zz', { desc = 'Scroll Down', noremap = true, silent = true })
vim.keymap.set('v', '<C-u>', '<C-u>zz', { desc = 'Scroll Up', noremap = true, silent = true })

-- Keep selection after indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Indent Left', noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent Right', noremap = true, silent = true })

-- VS Code specific navigation mappings
vim.keymap.set('n', 'gh', '<Cmd>call VSCodeNotify("editor.action.showHover")<CR>', { desc = 'Show Hover' })
vim.keymap.set('n', 'gd', '<Cmd>call VSCodeNotify("editor.action.revealDefinition")<CR>', { desc = 'Go to Definition' })
vim.keymap.set('n', 'gD', '<Cmd>call VSCodeNotify("editor.action.peekDefinition")<CR>', { desc = 'Peek Definition' })
vim.keymap.set('n', 'gf', '<Cmd>call VSCodeNotify("editor.action.revealDeclaration")<CR>', { desc = 'Go to Declaration' })
vim.keymap.set('n', 'gF', '<Cmd>call VSCodeNotify("editor.action.peekDeclaration")<CR>', { desc = 'Peek Declaration' })
vim.keymap.set('n', 'gH', '<Cmd>call VSCodeNotify("editor.action.referenceSearch.trigger")<CR>', { desc = 'Find References' })
vim.keymap.set('n', 'gO', '<Cmd>call VSCodeNotify("workbench.action.gotoSymbol")<CR>', { desc = 'Go to Symbol' })

-- VS Code window management
vim.keymap.set('n', '<C-w>gd', '<Cmd>call VSCodeNotify("editor.action.revealDefinitionAside")<CR>', { desc = 'Go to Definition Aside' })
vim.keymap.set('n', '<C-w>gf', '<Cmd>call VSCodeNotify("editor.action.revealDefinitionAside")<CR>', { desc = 'Go to Declaration Aside' })

-- Format selection
vim.keymap.set('n', '=', '<Cmd>call VSCodeNotify("editor.action.formatSelection")<CR>', { desc = 'Format Selection' })
vim.keymap.set('x', '=', '<Cmd>call VSCodeNotify("editor.action.formatSelection")<CR>', { desc = 'Format Selection' })

-- VS Code specific file operations
vim.keymap.set('n', '<leader>e', '<Cmd>call VSCodeNotify("workbench.view.explorer")<CR>', { desc = 'Explorer' })
vim.keymap.set('n', '<leader>f', '<Cmd>call VSCodeNotify("workbench.action.quickOpen")<CR>', { desc = 'Quick Open' })
vim.keymap.set('n', '<leader>F', '<Cmd>call VSCodeNotify("workbench.action.findInFiles")<CR>', { desc = 'Find in Files' })
vim.keymap.set('n', '<leader>s', '<Cmd>call VSCodeNotify("workbench.action.gotoSymbol")<CR>', { desc = 'Go to Symbol' })
vim.keymap.set('n', '<leader>S', '<Cmd>call VSCodeNotify("workbench.action.showAllSymbols")<CR>', { desc = 'Show All Symbols' })

-- VS Code command palette
vim.keymap.set('n', '<leader>p', '<Cmd>call VSCodeNotify("workbench.action.showCommands")<CR>', { desc = 'Command Palette' })

-- VS Code settings
vim.keymap.set('n', '<leader>,', '<Cmd>call VSCodeNotify("workbench.action.openSettings")<CR>', { desc = 'Open Settings' })
vim.keymap.set('n', '<leader>k', '<Cmd>call VSCodeNotify("workbench.action.openKeybindings")<CR>', { desc = 'Open Keybindings' })

-- VS Code terminal
vim.keymap.set('n', '<leader>t', '<Cmd>call VSCodeNotify("workbench.action.terminal.toggleTerminal")<CR>', { desc = 'Toggle Terminal' })
vim.keymap.set('n', '<leader>T', '<Cmd>call VSCodeNotify("workbench.action.terminal.new")<CR>', { desc = 'New Terminal' })

-- VS Code problems panel
vim.keymap.set('n', '<leader>d', '<Cmd>call VSCodeNotify("workbench.actions.view.problems")<CR>', { desc = 'Problems Panel' })

-- VS Code source control
vim.keymap.set('n', '<leader>g', '<Cmd>call VSCodeNotify("workbench.view.scm")<CR>', { desc = 'Source Control' })

-- VS Code extensions
vim.keymap.set('n', '<leader>x', '<Cmd>call VSCodeNotify("workbench.extensions.action.showInstalledExtensions")<CR>', { desc = 'Extensions' })

-- VS Code workspace
vim.keymap.set('n', '<leader>w', '<Cmd>call VSCodeNotify("workbench.action.openRecent")<CR>', { desc = 'Recent Files' })

-- VS Code help
vim.keymap.set('n', '<leader>h', '<Cmd>call VSCodeNotify("workbench.action.showAllEditors")<CR>', { desc = 'Show All Editors' })

-- Enhanced window management using VS Code commands
local function manageEditorSize(count, direction)
    local count = count or 1
    for i = 1, count do
        if direction == 'increase' then
            vim.fn.VSCodeNotify('workbench.action.increaseViewSize')
        else
            vim.fn.VSCodeNotify('workbench.action.decreaseViewSize')
        end
    end
end

-- Window resize mappings (VS Code style)
vim.keymap.set('n', '<C-w>>', '<Cmd>lua manageEditorSize(vim.v.count, "increase")<CR>', { desc = 'Increase Window Size' })
vim.keymap.set('x', '<C-w>>', '<Cmd>lua manageEditorSize(vim.v.count, "increase")<CR>', { desc = 'Increase Window Size' })
vim.keymap.set('n', '<C-w>+', '<Cmd>lua manageEditorSize(vim.v.count, "increase")<CR>', { desc = 'Increase Window Size' })
vim.keymap.set('x', '<C-w>+', '<Cmd>lua manageEditorSize(vim.v.count, "increase")<CR>', { desc = 'Increase Window Size' })
vim.keymap.set('n', '<C-w><', '<Cmd>lua manageEditorSize(vim.v.count, "decrease")<CR>', { desc = 'Decrease Window Size' })
vim.keymap.set('x', '<C-w><', '<Cmd>lua manageEditorSize(vim.v.count, "decrease")<CR>', { desc = 'Decrease Window Size' })
vim.keymap.set('n', '<C-w>-', '<Cmd>lua manageEditorSize(vim.v.count, "decrease")<CR>', { desc = 'Decrease Window Size' })
vim.keymap.set('x', '<C-w>-', '<Cmd>lua manageEditorSize(vim.v.count, "decrease")<CR>', { desc = 'Decrease Window Size' }) 