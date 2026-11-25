# Lessons

- **Herdr: only `herdr-app` (GUI) and `herdr-core` (`hc`) are installed; the `herdr` TUI was removed (2026-11).** Its CLI (`herdr worktree create`, etc.) used a separate session server, so workspaces never showed in the app. Diagnose with `hc` and the app's `AGENTS.md`.
- **Before removing a tool, ask about anything that depends on it, don't decide alone.** I removed dadbod along with its DB terminal and the AeroSpace `alt-d` binding because I judged them dead, but Walter still used DBUI through that shortcut. When a removal drags other things with it (launchers, keybindings, scripts), list them and confirm first, and keep what the user says is in use.
- **Running `nvim` headless rewrites `nvim-pack-lock.json` and can reinstall removed plugins.** `vim.pack` repairs the lock for whatever the checked-out branch's config loads, so switching branches between test runs leaves stray changes. Check `git status` after any headless nvim test and discard lock noise before committing.
