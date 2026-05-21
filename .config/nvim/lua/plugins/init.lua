local function load(specs, mod)
    local ok, spec = pcall(require, mod)
    if not ok then
        vim.notify('packages: failed to load ' .. mod .. '\n' .. spec, vim.log.levels.ERROR)
    else
        table.insert(specs, spec)
    end
end

local specs = {}

-- Core
load(specs, 'plugins.deps')
load(specs, 'plugins.snacks')

-- UI
load(specs, 'plugins.ui.colorscheme')
load(specs, 'plugins.ui.nvim-web-devicons')
load(specs, 'plugins.ui.which-key')
load(specs, 'plugins.ui.incline')
load(specs, 'plugins.ui.lualine')

-- Editor
load(specs, 'plugins.editor.flash')
load(specs, 'plugins.editor.todo-comments')
load(specs, 'plugins.editor.mini')
load(specs, 'plugins.editor.smart-splits')
load(specs, 'plugins.editor.undo-tree')

-- LSP
load(specs, 'plugins.lsp.mason')
load(specs, 'plugins.lsp.lsp')

-- Linting
load(specs, 'plugins.linting.nvim-lint')
load(specs, 'plugins.linting.mason-nvim-lint')

-- Formatting
load(specs, 'plugins.conform-nvim')

-- Diagnostics
load(specs, 'plugins.trouble')

-- Git
load(specs, 'plugins.git.gitsigns')
load(specs, 'plugins.git.diffview')

-- Utils
load(specs, 'plugins.utils.cloak')
load(specs, 'plugins.utils.kulala')
load(specs, 'plugins.utils.hardtime')
load(specs, 'plugins.utils.precognition')

-- Languages
load(specs, 'plugins.treesitter.treesitter')
load(specs, 'plugins.languages.render-markdown-nvim')
load(specs, 'plugins.languages.obsidian')
load(specs, 'plugins.languages.image')
load(specs, 'plugins.languages.markdown-preview-nvim')

-- AI
load(specs, 'plugins.ai.copilot')
load(specs, 'plugins.ai.copilot-ls')

-- Completion
load(specs, 'plugins.completion.blink')
load(specs, 'plugins.completion.ts-comments')
load(specs, 'plugins.completion.yanky')

local all_plugins = {}
for _, spec in ipairs(specs) do
    for _, plugin in ipairs(spec.plugins or {}) do
        table.insert(all_plugins, plugin)
    end
end
vim.pack.add(all_plugins)

for _, spec in ipairs(specs) do
    if spec.setup then
        local ok, err = pcall(spec.setup)
        if not ok then
            vim.notify('packages: setup failed\n' .. err, vim.log.levels.ERROR)
        end
    end
end
