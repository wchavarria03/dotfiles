# CLAUDE.md

## Delegate to the notes vault

Walter keeps a personal notes vault at `/home/walter/notes` on the homelab server (`github.com/wchavarria03/notes`, private, org-roam), with its own `CLAUDE.md`, skills, and a `guard-main.sh` hook that blocks AI from touching `main` there. If you're running on that server and something in this repo is worth recording in the vault, don't read its rules by hand and write there directly from this session — delegate via:

```
/home/walter/notes/bin/capture "<what happened>"
```

Relay the proposal that call returns to Walter; on approval, resume with `capture "<his decision>" --continue` so the same session, genuinely rooted in the vault, does the actual write. If you're not on that server (e.g. local Mac work), just mention to Walter that this might be worth a note — he'll capture it himself.

## Dotfiles repo workflow

Applies only when the working directory is inside `~/personal/dotfiles` (this file is symlinked to `~/CLAUDE.md`, so ignore this section in any other project).

After every change to this repo:

1. Work on a feature branch, never directly on `master`.
2. Commit the change (conventional commit style, matching `git log`).
3. Push the branch and open a PR against `master` with `gh pr create`.
4. Display the PR URL to Walter for review. Do not merge it.

This is a standing instruction: no need to ask before committing, pushing, or opening the PR.
