local function get_packages()
    return vim.pack.get(nil, { info = false })
end

vim.api.nvim_create_user_command('PackUpdate', function()
    vim.pack.update()
end, { desc = 'Update all packages' })

vim.api.nvim_create_user_command('PackList', function()
    local packages = get_packages()
    if vim.tbl_isempty(packages) then
        vim.notify('No packages managed', vim.log.levels.WARN)
        return
    end

    local names = {}
    for _, pkg in ipairs(packages) do
        if pkg.spec and pkg.spec.name then
            local name = pkg.spec.name
            if pkg.active == false then
                name = name .. ' [inactive]'
            end
            table.insert(names, name)
        end
    end
    table.sort(names)
    vim.notify(table.concat(names, '\n'), vim.log.levels.INFO, { title = 'Installed packages (' .. #names .. ')' })
end, { desc = 'List installed packages' })

vim.api.nvim_create_user_command('PackClean', function()
    local packages = get_packages()
    local inactive = {}

    for _, pkg in ipairs(packages) do
        if pkg.active == false and pkg.spec and pkg.spec.name then
            table.insert(inactive, pkg.spec.name)
        end
    end

    if #inactive == 0 then
        vim.notify('Nothing to clean', vim.log.levels.INFO)
        return
    end

    table.sort(inactive)
    local ok, err = pcall(vim.pack.del, inactive)
    if not ok then
        vim.notify('PackClean failed:\n' .. tostring(err), vim.log.levels.ERROR, { title = 'PackClean' })
        return
    end

    vim.notify('Removed:\n' .. table.concat(inactive, '\n'), vim.log.levels.INFO, { title = 'PackClean' })
end, { desc = 'Remove packages not declared in vim.pack' })
