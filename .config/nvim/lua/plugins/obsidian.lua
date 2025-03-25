return {
  "epwalsh/obsidian.nvim",
  version = "*",
  ft = "markdown",
  event = "BufEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "Notes",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes",
      },
    },

    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url }) -- Mac OS
    end,

    new_notes_location = "notes_subdir",

    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      if note.title then
        note:add_alias(note.title)
      end

      local out = { id = note.id, aliases = note.aliases, tags = note.tags }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,

    open_notes_in = "vsplit",

    preferred_link_style = "markdown",

    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
      substitutions = {},
    },
  },
}
