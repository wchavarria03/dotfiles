# Plan: nvim plugin usage logger

Goal: silently record which config files / plugins I actually trigger, so unused plugins are visible.

## Design
- Counts live in `stdpath('state')/plugin-usage.json`, shape `{ [owner] = { [key] = n } }`.
- `owner` = config file that registered the keymap (`plugins/editor/flash.lua`) or `core/...`.
- Install BEFORE `core.keymaps` and `plugins` load, or their mappings are missed.
- Flush on `VimLeavePre`, merging with the previous file (totals accumulate across sessions).

## Steps
- [x] 1. `core/usage.lua`: `owner()` helper (walk `debug.getinfo` levels, skip this file)
- [x] 2. Wrap `vim.keymap.set`: function rhs counted directly; string rhs wrapped via `<Cmd>`/expr-safe callback (decide approach)
- [x] 3. `CmdlineLeave` autocmd: count first word of executed ex command
- [x] 4. `VimLeavePre`: read old json, add counts, write back
- [x] 5. `:PluginUsage` command: print table sorted by count, plus plugins with zero (`vim.pack.get()` minus owners)
- [x] 6. Wire `require('core.usage').setup()` first in `core/init.lua`
- [x] 7. Verify: press mappings, quit, inspect json; confirm no startup-time regression

## Open questions
- Buffer-local mappings (`opts.buffer`): wrap too?
- Mappings with `expr = true` or `remap`: wrapper must preserve return value.
- Multiple nvim instances flushing at once: last-writer-wins acceptable?

## Result
- String rhs: only `<Cmd>...` mappings are wrapped (via feedkeys, `nt`). Other string rhs (`<Plug>`, plain keys) are skipped entirely so they cannot flag an owner as unused.
- Verified headless: `<C-h>` press counted under `plugins/editor/smart-splits.lua`; startup ~0.27s total.
- Not counted: `<Plug>`/plain-key mappings, mappings plugins create via `nvim_set_keymap`, commands run via `:lua`/mappings (only typed cmdline).
