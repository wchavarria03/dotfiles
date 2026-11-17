# Lessons

- **Herdr: herdr-app and herdr-mobile run on `herdr-core` (`hc`), never the `herdr` TUI.** Don't use TUI docs, `herdr agent list`, `herdr integration`, or the `herdr-agent-state.sh` hook (it targets the TUI socket and `HERDR_*` env vars) to explain app/mobile behavior. Diagnose with `hc` and the app's `AGENTS.md` instead.
