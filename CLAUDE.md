# CLAUDE.md

## Delegate to the notes vault

Walter keeps a personal notes vault at `/home/walter/notes` on the homelab server (`github.com/wchavarria03/notes`, private, Markdown files with Obsidian for linking and graph view), with its own `CLAUDE.md`, skills, and a `guard-main.sh` hook that blocks AI from touching `main` there. If something in this repo is worth recording in the vault (a decision, or research worth keeping), don't read its rules by hand or write there directly from this session — delegate. See section 8 of `.claude/CLAUDE.md` for the full rule.

- **Preferred:** send a self-contained summary to the running herdr notes session (`ListAgents` + `SendMessage`).
- **Alternative:** `/home/walter/notes/bin/capture "<what happened>"` when the script is useful (it runs a session genuinely rooted in the vault). Use it for the write itself, not as a review step.
- **Either way, the end result is a PR** against the vault's default branch. Walter reviews only the final PR link: don't relay proposals, drafts, or intermediate states, and never merge.
- If you're not on the homelab server (e.g. local Mac work), just mention to Walter that this might be worth a note — he'll capture it himself.
