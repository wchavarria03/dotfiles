# Git config pieces

Stowed to `~/.config/git/`. The main `~/.gitconfig` (symlink to `dotfiles/.gitconfig`) pulls these in.

| File | Purpose | Loaded from |
|------|---------|-------------|
| `ignore` | Global gitignore. Git reads `~/.config/git/ignore` automatically. | Git default |
| `gitconfig.mac.signing` | Commit signing with 1Password SSH (`op-ssh-sign`). macOS only. | `~/.gitconfig.local`, added by `setup/setup_stow.sh` |
| `gitconfig.personal` | GitHub credential helper for repos under `~/personal/`. Resets the helper list first so `osxkeychain` can't serve a stale credential. | `includeIf "gitdir:~/personal/"` in `~/.gitconfig.local`, added by `setup/setup_stow.sh` (macOS only) |
| `gitconfig.work` | Same helper for repos under `~/work/`. Separate file so each tree can diverge later. | `includeIf "gitdir:~/work/"` in `~/.gitconfig.local`, added by `setup/setup_stow.sh` (macOS only) |
| `git-credential-pat` | Credential helper script. Answers `get` with `$GITHUB_PAT`; ignores `store`/`erase`. | `gitconfig.personal` |

## How GitHub auth works

1. direnv loads `GITHUB_PAT` from the nearest `.envrc`: `~/personal/.envrc` or `~/work/.envrc` (untracked, never commit them). Both read 1Password with `op read --account <account> ...`: personal from `my.1password.com` (`Private` vault), work from `ltvco.1password.com` (`Employee` vault).
2. Git sees an HTTPS GitHub URL inside `~/personal/` or `~/work/` and runs `git-credential-pat`.
3. The script prints the username and token and git authenticates.

Rules:

- Remote URLs stay plain: `https://github.com/<owner>/<repo>.git`. No token in the URL, no `url.*.insteadOf` rewrite carrying a token. Embedded credentials take priority over the helper and silently win.
- `~/.gitconfig.local` is machine-local and untracked. Don't put tokens in it.
- A new directory with its own token follows the same pattern: its own `.envrc`, a `gitconfig.<name>`, and an `includeIf` in `~/.gitconfig.local` (add it to `ensure_gitconfig_local_github_auth` in `setup/setup_stow.sh` too).
- The `includeIf` blocks are deliberately not in the portable `.gitconfig`. Windows keeps Git Credential Manager; clearing the helper there would break HTTPS auth.
- SSH remotes (`git@github.com:...`) ignore all of this and use your SSH key.

## Setup on a new machine

See "GitHub auth" in `setup/README.md`. Verify with `git ls-remote origin HEAD` inside an HTTPS repo under `~/personal/` or `~/work/`.
