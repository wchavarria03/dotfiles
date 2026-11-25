# CLAUDE.md

## Delegate to the notes vault

Walter keeps a personal notes vault at `/home/walter/notes` on the homelab server (`github.com/wchavarria03/notes`, private, Markdown files with Obsidian for linking and graph view), with its own `CLAUDE.md`, skills, and a `guard-main.sh` hook that blocks AI from touching `main` there. If something in this repo is worth recording in the vault (a decision, or research worth keeping), don't read its rules by hand or write there directly from this session — delegate. See section 8 of `.claude/CLAUDE.md` for the full rule.

- **Preferred:** send a self-contained summary to the running herdr notes session (`ListAgents` + `SendMessage`).
- **Alternative:** `/home/walter/notes/bin/capture "<what happened>"` when the script is useful (it runs a session genuinely rooted in the vault). Use it for the write itself, not as a review step.
- **Either way, the end result is a PR** against the vault's default branch. Walter reviews only the final PR link: don't relay proposals, drafts, or intermediate states, and never merge.
- If you're not on the homelab server (e.g. local Mac work), just mention to Walter that this might be worth a note — he'll capture it himself.

## Dotfiles repo rules (only when working in `~/personal/dotfiles`)

This file is symlinked to `~/CLAUDE.md`, so ignore this section in any other project.

- **This repo is public.** Never commit company names, internal URLs, Jira or Confluence ids, tokens, or work 1Password references. They live in the private repo `~/personal/secrets` (`zsh/work.zsh`, `env/`, `claude/skills/`, linked by its `link.sh`).
- **PATH is set in one block** in `.config/zsh/.zshrc`. Don't add `export PATH=...` elsewhere. `~/.zprofile` is never read because `ZDOTDIR` points at `~/.config/zsh`.
- **A new shell must read no secret and call no `op`.** Secrets load on first use of the tool that needs them.
- **Headless `nvim` rewrites `.config/nvim/nvim-pack-lock.json`** and can reinstall removed plugins, because `vim.pack` repairs the lock for whatever the checked-out branch loads. After any headless nvim test, check `git status` and discard lock noise before committing.
