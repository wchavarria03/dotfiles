return {
  {
    "laytan/cloak.nvim",
    event = "VeryLazy",
    config = function()
      require("cloak").setup({
        enabled = true,
        cloak_character = "*",
        -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
        highlight_group = "Comment",
        patterns = {
          {
            -- Match any file starting with '.env'.
            -- This can be a table to match multiple file patterns.
            file_pattern = {
              ".env*",
              "env.*",
              ".dev*",
              "dev.*",
              "*-secrets.zsh",
              "git.inc",
              "hosts.json",
              "config.json",
            },
            -- Match an equals sign and any character after it.
            -- This can also be a table of patterns to cloak,
            -- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
            cloak_pattern = {
              "=.+",
              { "(https://ghp_).+", replace = "%1" },
              { '("oauth_token": "ghu_).+', replace = "%1" },
              { '("token" : ).+', replace = "%1" },
              { '("accesstoken" :).+', replace = "%1" },
            },
          },
        },
      })
      require("snacks")
        .toggle({
          name = "Cloak",
          get = function()
            return vim.b.cloak_enabled
          end,
          set = function(state)
            require("cloak").toggle(state)
          end,
        })
        :map("<leader>tC")
    end,
  },
}
