# CLAUDE.md

## Delegate to the notes vault

Walter keeps a personal notes vault at `/home/walter/notes` on the homelab server (`github.com/wchavarria03/notes`, private, org-roam), with its own `CLAUDE.md`, skills, and a `guard-main.sh` hook that blocks AI from touching `main` there. If you're running on that server and something in this repo is worth recording in the vault, don't read its rules by hand and write there directly from this session — delegate via:

```
/home/walter/notes/bin/capture "<what happened>"
```

Relay the proposal that call returns to Walter; on approval, resume with `capture "<his decision>" --continue` so the same session, genuinely rooted in the vault, does the actual write. If you're not on that server (e.g. local Mac work), just mention to Walter that this might be worth a note — he'll capture it himself.
