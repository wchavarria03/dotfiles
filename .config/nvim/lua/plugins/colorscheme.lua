local colorsConfigs = require 'config.colorschema-overrides'

return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false, -- Load immediately for better UX
        priority = 1000, -- Load early
        opts = function()
            math.randomseed(os.time())
            local randomIndex = math.random(#colorsConfigs)

            return colorsConfigs[randomIndex]
        end,
        config = function(_, opts)
            require('catppuccin').setup(opts)
            vim.cmd.colorscheme 'catppuccin-macchiato'
        end,
    },
    -- Alternative themes - lazy load only when needed
    -- {
    --     'rose-pine/neovim',
    --     name = 'rose-pine',
    --     lazy = true,
    --     cmd = 'RosePine',
    --     config = function()
    --         require('rose-pine').setup {
    --             variant = 'main',
    --             dark_variant = 'main',
    --             styles = {
    --                 bold = true,
    --                 italic = false,
    --             },
    --             highlight_groups = {
    --                 CursorLineNr = { fg = '#ebbcba' },
    --                 CursorLine = { bg = '#232136' },
    --                 NormalFloat = { bg = '#232136' },
    --                 FloatBorder = { fg = '#ebbcba', bg = '#232136' },
    --             },
    --         }
    --     end,
    -- },
    -- {
    --     'rebelot/kanagawa.nvim',
    --     lazy = true,
    --     cmd = 'Kanagawa',
    --     config = function()
    --         require('kanagawa').setup {
    --             compile = false,
    --             undercurl = true,
    --             commentStyle = { italic = true },
    --             functionStyle = {},
    --             keywordStyle = { italic = false },
    --             statementStyle = { bold = true },
    --             typeStyle = {},
    --             transparent = true,
    --             dimInactive = false,
    --             terminalColors = true,
    --             colors = {
    --                 palette = {},
    --                 theme = {
    --                     wave = {},
    --                     dragon = {},
    --                     all = {
    --                         ui = {
    --                             bg_gutter = 'none',
    --                             border = 'rounded',
    --                         },
    --                     },
    --                 },
    --             },
    --             overrides = function(colors)
    --                 local theme = colors.theme
    --                 return {
    --                     NormalFloat = { bg = 'none' },
    --                     FloatBorder = { bg = 'none' },
    --                     FloatTitle = { bg = 'none' },
    --                     Pmenu = { fg = theme.ui.shade0, bg = 'NONE', blend = vim.o.pumblend },
    --                     PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
    --                     PmenuSbar = { bg = theme.ui.bg_m1 },
    --                     PmenuThumb = { bg = theme.ui.bg_p2 },
    --
    --                     -- Save an hlgroup with dark background and dimmed foreground
    --                     -- so that you can use it where your still want darker windows.
    --                     -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
    --                     NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
    --
    --                     -- Popular plugins that open floats will link to NormalFloat by default;
    --                     -- set their background accordingly if you wish to keep them dark and borderless
    --                     LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
    --                     MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
    --                     TelescopeTitle = { fg = theme.ui.special, bold = true },
    --                     TelescopePromptBorder = { fg = theme.ui.special },
    --                     TelescopeResultsNormal = { fg = theme.ui.fg_dim },
    --                     TelescopeResultsBorder = { fg = theme.ui.special },
    --                     TelescopePreviewBorder = { fg = theme.ui.special },
    --                 }
    --             end,
    --             theme = 'wave', -- Load "wave" theme when 'background' option is not set
    --             background = { -- map the value of 'background' option to a theme
    --                 dark = 'wave', -- try "dragon" !
    --             },
    --         }
    --     end,
    -- },
    -- {
    --     'craftzdog/solarized-osaka.nvim',
    --     lazy = true,
    --     cmd = 'SolarizedOsaka',
    --     config = function()
    --         require('solarized-osaka').setup {
    --             transparent = true,
    --             terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
    --             styles = {
    --                 -- Style to be applied to different syntax groups
    --                 -- Value is any valid attr-list value for `:help nvim_set_hl`
    --                 comments = { italic = true },
    --                 keywords = { italic = false },
    --                 functions = {},
    --                 variables = {},
    --                 -- Background styles. Can be "dark", "transparent" or "normal"
    --                 sidebars = 'dark', -- style for sidebars, see below
    --                 floats = 'dark', -- style for floating windows
    --             },
    --             sidebars = { 'qf', 'help' }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    --             day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    --             hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    --             dim_inactive = false, -- dims inactive windows
    --             lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
    --             on_highlights = function(hl, c)
    --                 local prompt = '#2d3149'
    --                 hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
    --                 hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
    --                 hl.TelescopePromptNormal = { bg = c.bg_dark }
    --                 hl.TelescopePromptBorder = { bg = c.bg_dark, fg = c.bg_dark }
    --                 hl.TelescopePromptTitle = { bg = prompt, fg = '#2C94DD' }
    --                 hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
    --                 hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
    --             end,
    --         }
    --     end,
    -- },
    -- {
    --     'folke/tokyonight.nvim',
    --     name = 'folkeTokyonight',
    --     lazy = true,
    --     cmd = 'TokyoNight',
    --     config = function()
    --         require('tokyonight').setup {
    --             style = 'night',
    --             styles = {
    --                 comments = { italic = false },
    --                 keywords = { italic = false },
    --             },
    --         }
    --
    --         -- vim.cmd.colorscheme("tokyonight")
    --         -- vim.cmd("colorscheme tokyonight")
    --         -- NOTE: Auto switch to tokyonight for markdown files only
    --         -- vim.api.nvim_create_autocmd("FileType", {
    --         --     pattern = { "markdown" },
    --         --     callback = function()
    --         --         -- Ensure the theme switch only happens once for a buffer
    --         --         local buffer = vim.api.nvim_get_current_buf()
    --         --         if not vim.b[buffer].tokyonight_applied then
    --         --             if vim.fn.expand("%:t") ~= "" and vim.api.nvim_buf_get_option(0, "buftype") ~= "nofile" then
    --         --                 vim.cmd("colorscheme tokyonight")
    --         --             end
    --         --             vim.b[buffer].tokyonight_applied = true
    --         --         end
    --         --     end,
    --         -- })
    --     end,
    -- },
}
