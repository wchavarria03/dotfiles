vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Buffers navigation
vim.keymap.set("n", "<C-k>", "<C-w><up>", { desc = "Move Up", expr = true, silent = true })
vim.keymap.set("n", "<C-h>", "<C-w><left>", { desc = "Move Left", expr = true, silent = true })

-- Avoid Arrow Keys
vim.keymap.set("", "<up>", "<nop>", { desc = "Global: Arrow up disabled" })
vim.keymap.set("", "<down>", "<nop>", { desc = "Global: Arrow down disabled" })
vim.keymap.set("", "<left>", "<nop>", { desc = "Global: Arrow left disabled" })
vim.keymap.set("", "<right>", "<nop>", { desc = "Global: Arrow right disabled" })

-- Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Global: Move Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Global: Move Right Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Global: Move Up Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Global: Move Down Window" })

-- Escape mapping
vim.keymap.set("i", "jk", "<Esc>", { desc = "Global: Escape" })
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Global: Escape" })

-- Clear search highlighting
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Global: Clear Selection", silent = true })

-- Next and previous result centered
vim.keymap.set("n", "n", "nzzzv", { desc = "Scroll Down", noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Scroll Up", noremap = true, silent = true })

-- Scroll and keep cursor centered
vim.keymap.set("v", "<C-d>", "<C-d>zz", { desc = "Scroll Down", noremap = true, silent = true })
vim.keymap.set("v", "<C-u>", "<C-u>zz", { desc = "Scroll Up", noremap = true, silent = true })

-- keep highlight after indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent", noremap = true, silent = true })
vim.keymap.set("v", "<", ">gv", { desc = "Indent", noremap = true, silent = true })

-- Windows
vim.keymap.set("n", "<C-->", ":vsplit<CR>", { desc = "Global: Window Split Vert" })
vim.keymap.set("n", "<C-\\>", ":split<CR>", { desc = "Global: Window Split Hori" })
vim.keymap.set("n", "<C-\\>", ":split<CR>", { desc = "Global: Window Split Hori" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C->", "<cmd>resize +5<cr>", { desc = "Global: Increase Window Height" })
vim.keymap.set("n", "<C->", "<cmd>resize -5<cr>", { desc = "Global: Decrease Window Height" })
vim.keymap.set("n", "<C-<>", "<cmd>vertical resize -5<cr>", { desc = "Global: Decrease Window Width" })
vim.keymap.set("n", "<C->>", "<cmd>vertical resize +5<cr>", { desc = "Global: Increase Window Width" })

vim.keymap.set(
  "n",
  "<leader>tr",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

vim.schedule(function()
  local snacks = require("snacks")
  snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
  snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
  snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tL")
  snacks.toggle.diagnostics():map("<leader>td")
  snacks.toggle.line_number():map("<leader>tl")
  snacks.toggle
    .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" })
    :map("<leader>tc")
  snacks.toggle.treesitter():map("<leader>tT")
  snacks.toggle.dim():map("<leader>tD")
  snacks.toggle.animate():map("<leader>ta")
  snacks.toggle.indent():map("<leader>ti")
  snacks.toggle.scroll():map("<leader>tS")

  if vim.lsp.inlay_hint then
    snacks.toggle.inlay_hints():map("<leader>th")
  end
  snacks.toggle.zoom():map("<leader>tZ")
  snacks.toggle.zen():map("<leader>tz")

  snacks
    .toggle({
      name = "Mini Pairs",
      get = function()
        return not vim.g.minipairs_disable
      end,
      set = function(state)
        vim.g.minipairs_disable = not state
      end,
    })
    :map("<leader>tp")

  snacks.toggle
    .new({
      id = "Format on Save",
      name = "Format on Save",
      get = function()
        return vim.g.autoformat
      end,
      set = function(_)
        vim.g.autoformat = not vim.g.autoformat
      end,
    })
    :map("<leader>tf")

  -- highlights under cursor
  vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
  vim.keymap.set("n", "<leader>uI", function()
    vim.treesitter.inspect_tree()
    vim.api.nvim_input("I")
  end, { desc = "Inspect Tree" })
end)

-- -- Clear search and close snippet
-- vim.keymap.set({ "i", "n", "s" }, "<esc>", function()
--   vim.cmd("noh")
--
--   -- TODO: Test if this is working as expected
--   if require("luasnip").expand_or_jumpable() then
--     require("luasnip").unlink_current()
--     return true
--   end
--
--   return "<esc>"
-- end, { expr = true, desc = "Escape and Clear hlsearch" })

-- Save/Write file
-- vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
