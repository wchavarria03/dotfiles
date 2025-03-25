return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      preview_config = {
        border = "rounded",
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")

        map("n", "]H", function()
          gs.nav_hunk("last")
        end, "Last Hunk")

        map("n", "[H", function()
          gs.nav_hunk("first")
        end, "First Hunk")

        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")

        map("n", "<leader>ghB", function()
          gs.blame()
        end, "Blame Buffer")

        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function()
          gs.diffthis("~")
        end, "Diff This ~")

        map("n", "<leader>ghQ", function()
          gs.setqflist("all")
        end)

        map("n", "<leader>ghq", gs.setqflist, "Set Quick List")

        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)

      require("snacks")
        .toggle({
          name = "Git Signs",
          get = function()
            return require("gitsigns.config").config.signcolumn
          end,
          set = function(state)
            require("gitsigns").toggle_signs(state)
          end,
        })
        :map("<leader>tgs")

      require("snacks")
        .toggle({
          name = "Git Word",
          get = function()
            return require("gitsigns.config").config.word_diff
          end,
          set = function(state)
            require("gitsigns").toggle_word_diff(state)
          end,
        })
        :map("<leader>tgw")

      require("snacks")
        .toggle({
          name = "Git blame line",
          get = function()
            return require("gitsigns.config").config.current_line_blame
          end,
          set = function(state)
            require("gitsigns").toggle_current_line_blame(state)
          end,
        })
        :map("<leader>tb")
    end,
  },
}
