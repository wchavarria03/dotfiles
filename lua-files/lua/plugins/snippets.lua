return {
  {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    version = '1.*',
    build = 'make install_jsregexp',
    opts = {
      history = true,
      updateevents = "TextChanged,TextChangedI"
    },
    config = function(_, opts)
      local luasnip = require("luasnip")
      luasnip.setup(opts)

      -- vscode format
      require("luasnip.loaders.from_vscode").lazy_load()

      luasnip.filetype_extend("ruby", {"rails"})

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if
            require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
    dependencies = {
      'rafamadriz/friendly-snippets',
      "saadparwaiz1/cmp_luasnip",
    },
  }
}
