-----------------------------------------------------------
 -- Statusline configuration file ---------------------------------------------------------

--[[
  Plugin: lualine.nvim
  https://github.com/nvim-lualine/lualine.nvim
--]]

-- Load the onenord theme for lualine
local onenord = require('lualine.themes.onenord')
local colors = {
  bg = '#839982',
  bg_inactive ='#90a4b0',
  fg = '#000000',
  --[[
  yellow = '#e5c07b',
  cyan = '#8abeb7',
  darkblue = '#528bff',
  green = '#98c379',
  orange = '#d19a66',
  violet = '#b294bb',
  magenta = '#ff80ff',
  blue = '#61afef';
  red = '#e88388';
  --]]
}

local comps = {
  file_name = {
    'filename',
    file_status = true,      -- Displays file status (readonly status, modified status)
    newfile_status = false,  -- Display new file status (new file means no write after created)
    path = 1,                -- 0: Just the filename
                             -- 1: Relative path
                             -- 2: Absolute path
                             -- 3: Absolute path, with tilde as the home directory
                             -- 4: Filename and parent dir, with tilde as the home directory

    shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                             -- for other components. (terrible name, any suggestions?)
    symbols = {
      modified = ' ',      -- Text to show when the buffer is modified
      readonly = ' 🔒',      -- Text to show when the file is non-modifiable or readonly.
      unnamed = '[No Name]', -- Text to show for unnamed buffers.
      newfile = '[New]',     -- Text to show for newly created file before first write
      directory =  '',     -- Text to show when the buffer is a directory
      alternate_file = '#', -- Text to show to identify the alternate file
    }
  },
  diff = {
    'diff',
    colored = true, -- Displays a colored diff status if set to true
    diff_color = {
      -- Same color values as the general color option can be used here.
      added    = 'DiffAdd',    -- Changes the diff's added color
      modified = 'DiffChange', -- Changes the diff's modified color
      removed  = 'DiffDelete', -- Changes the diff's removed color you
    },
    symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the symbols used by the diff.
    source = nil, -- A function that works as a data source for diff.
                  -- It must return a table as such:
                  --   { added = add_count, modified = modified_count, removed = removed_count }
                  -- or nil on failure. count <= 0 won't be displayed.
  },
  diagnostics = {
    'diagnostics',

    -- Table of diagnostic sources, available sources are:
    --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
    -- or a function that returns a table as such:
    --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
    sources = { 'nvim_lsp' },

    -- Displays diagnostics for the defined severity types
    sections = { 'error', 'warn', 'info', 'hint' },

    diagnostics_color = {
      -- Same values as the general color option can be used here.
      error = 'DiagnosticError', -- Changes diagnostics' error color.
      warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
      info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
      hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
    },
    symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
    colored = true,           -- Displays diagnostics status in color if set to true.
    update_in_insert = false, -- Update diagnostics in insert mode.
    always_visible = false,   -- Show diagnostics even if there are none.
  }
}

-- Override inactive colors
onenord.inactive = {
  c = { bg = colors.bg_inactive, fg = colors.fg, gui = 'bold' },
}

local function is_nvim_tree()
  local buftype = vim.bo.buftype
  local filetype = vim.bo.filetype
  return buftype == 'terminal' or (filetype == 'NvimTree' and vim.fn.exists('g:nvim_tree_window_id') == 1)
end

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = onenord,
    component_separators = {
      left = '',
      right = ''
    },
    section_separators = {
      left = '',
      right = ''
    },
    disabled_filetypes = {
      'packer',
      'NVimTree' ,
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      comps.diff,
      comps.diagnostics
    },
    lualine_c = {
      comps.file_name
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      comps.file_name
    },
    lualine_y = {},
    lualine_x = {'progress'},
    lualine_z = {'location'}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = { 'nvim-tree' },
  filetypes = { 'NvimTree' },
  conditional = is_nvim_tree,
})
