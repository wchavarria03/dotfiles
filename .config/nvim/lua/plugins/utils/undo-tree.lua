-- 1. Load the built-in optional package (Equivalent to :packadd nvim.undotree)
vim.cmd 'packadd nvim.undotree'

-- 2. Define a function to open the undotree window
local function undotree_open(opts)
    -- Safely require the module and call the open function
    local undotree_ok, undotree = pcall(require, 'undotree')

    if undotree_ok and undotree.open then
        undotree.open(opts)
    else
        vim.notify("Error: 'undotree' module or 'open' function not available.", vim.log.levels.ERROR)
    end
end

-- 3. Key Mapping: Map <leader>u to open the undotree
vim.keymap.set('n', '<leader>uu', function()
    -- You can pass options directly here if desired
    undotree_open {
        -- Example of customizing the window split command:
        command = 'topleft 30vnew',
        title = 'Undotree Viewer',
    }
end, {
    desc = 'Open Undo Tree',
    silent = true,
})
