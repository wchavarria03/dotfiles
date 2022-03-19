-----------------------------------------------------------
 -- Statusline configuration file ---------------------------------------------------------

--[[
  Plugin: feline.nvim
  https://github.com/famiu/feline.nvim
  Thanks to ibhagwan for the example to follow
  see: https://github.com/ibhagwan/nvim-lua
--]]

local colors = {
  bg = '#839982',
  bg_inactive ='#90a4b0',
  fg = '#000000',
  yellow = '#e5c07b',
  cyan = '#8abeb7',
  darkblue = '#528bff',
  green = '#98c379',
  orange = '#d19a66',
  violet = '#b294bb',
  magenta = '#ff80ff',
  blue = '#61afef';
  red = '#e88388';
}

local vi_mode_colors = {
  NORMAL = colors.green,
  INSERT = colors.blue,
  VISUAL = colors.violet,
  OP = colors.green,
  BLOCK = colors.blue,
  REPLACE = colors.red,
  ['V-REPLACE'] = colors.red,
  ENTER = colors.cyan,
  MORE = colors.cyan,
  SELECT = colors.orange,
  COMMAND = colors.magenta,
  SHELL = colors.green,
  TERM = colors.blue,
  NONE = colors.yellow
}

-- Display vim mode text on statusline
local vi_mode_text = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    [''] = "V-BLOCK",
    V = "V-LINE",
    c = "COMMAND",
    no = "UNKNOWN",
    s = "UNKNOWN",
    S = "UNKNOWN",
    ic = "UNKNOWN",
    R = "REPLACE",
    Rv = "UNKNOWN",
    cv = "UNKWON",
    ce = "UNKNOWN",
    r = "REPLACE",
    rm = "UNKNOWN",
    t = "INSERT"
}

local vi_mode_utils = require('feline.providers.vi_mode')

-- my components
local comps = {
  vi_mode = {
    left = {
      provider = function()
        local current_text = ' '..vi_mode_text[vim.fn.mode()]..' '
        return current_text
      end,
      hl = function()
        return {
          name = vi_mode_utils.get_mode_highlight_name(),
          fg = colors.fg,
          bg = vi_mode_utils.get_mode_color(), -- vi_mode_utils.get_mode_color(),
          style = 'bold'
        }
      end,
    }
  },
  -- File info
  file = {
    info = {
      provider = {
          name = 'file_info',
          opts = {
              type = 'relative',
              colored_icon = false,
              file_modified_icon = ''
          }
      },
      short_provider = {
          name = 'file_info',
          opts = {
              type = 'relative-short',
              colored_icon = false,
              file_modified_icon = ''
          }
      },
      hl = {
        fg = colors.fg,
        bg = colors.bg,
        style = 'bold'
      },
      padding = 1,
      left_sep = {
        str = 'block',
        hl = {
          fg = colors.bg,
          bg = colors.bg,
        }
      },
      right_sep = {
        str = 'block',
        hl = {
          fg = colors.bg,
          bg = colors.bg,
        }
      }
    },
    info_inactive = {
      provider = {
          name = 'file_info',
          opts = {
              type = 'relative',
              colored_icon = false,
              file_modified_icon = ''
          }
      },
      short_provider = {
          name = 'file_info',
          opts = {
              type = 'relative-short',
              colored_icon = false,
              file_modified_icon = ''
          }
      },
      hl = {
        fg = colors.fg,
        bg = colors.bg_inactive,
        style = 'bold'
      },
      padding = 1,
      left_sep = {
        str = 'block',
        hl = {
          fg = colors.bg_inactive,
          bg = colors.bg_inactive,
        }
      },
      right_sep = {
        str = 'block',
        hl = {
          fg = colors.bg_inactive,
          bg = colors.bg_inactive,
        }
      }
    },
    position = {
      provider = { name = 'position' },
      hl = {
        style = 'bold'
      },
      left_sep = ' ',
    },
    line_percentage = {
      provider = 'line_percentage',
      hl = {
        fg = colors.magenta,
        style = 'bold'
      },
      left_sep = ' ',
      right_sep = ' ',
    },
  },
  -- LSP info
  diagnos = {
    err = {
      provider = 'diagnostic_errors',
      hl = { fg = colors.red },
      left_sep = ' ',
    },
    warn = {
      provider = 'diagnostic_warnings',
      hl = { fg = colors.yellow },
      left_sep = ' ',
    },
    info = {
      provider = 'diagnostic_info',
      hl = { fg = colors.blue },
      left_sep = ' ',
    },
    hint = {
      provider = 'diagnostic_hints',
      hl = { fg = colors.magenta },
      left_sep = ' ',
      right_sep = ' ',
    },
  },
  lsp = {
    name = {
      provider = 'lsp_client_names',
      icon = ' ',
      hl = { fg = colors.yellow },
    }
  },
  -- git info
  git = {
    branch = {
      provider = 'git_branch',
      icon = ' ',
      hl = {
        fg = colors.violet,
        style = 'bold'
      },
      left_sep = ' ',
    },
    add = {
      provider = 'git_diff_added',
      hl = { fg = colors.green },
    },
    change = {
      provider = 'git_diff_changed',
      hl = { fg = colors.orange },
    },
    remove = {
      provider = 'git_diff_removed',
      hl = { fg = colors.red },
    }
  }
}

local components = {
  active = {},
  inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

table.insert(components.active[1], comps.vi_mode.left)
table.insert(components.active[1], comps.file.info)
table.insert(components.active[1], comps.git.branch)
table.insert(components.active[1], comps.git.add)
table.insert(components.active[1], comps.git.change)
table.insert(components.active[1], comps.git.remove)
table.insert(components.inactive[1], comps.vi_mode.left)
table.insert(components.inactive[1], comps.file.info_inactive)

table.insert(components.active[2], comps.diagnos.err)
table.insert(components.active[2], comps.diagnos.warn)
table.insert(components.active[2], comps.diagnos.hint)
table.insert(components.active[2], comps.diagnos.info)
table.insert(components.active[2], comps.lsp.name)
table.insert(components.active[2], comps.file.position)
table.insert(components.active[2], comps.file.line_percentage)

require('feline').setup({
  default_bg = colors.bg,
  default_fg = colors.fg,
  components = components,
  vi_mode_colors = vi_mode_colors
})
