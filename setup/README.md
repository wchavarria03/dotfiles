# Machine Setup

Bootstrap scripts for setting up a new machine (macOS or the NixOS homeserver). Idempotent — safe to run multiple times.

---

## macOS

### Prerequisites

- Xcode (install from the App Store first, before running the script)
- SSH key configured for GitHub

### Usage

```bash
cd setup/
bash install.sh
```

### What it does

| Stage | Description |
|-------|-------------|
| 1 | Makes all scripts executable |
| 2 | Creates folders, installs Homebrew, packages, fonts, and asdf tool versions |
| 3 | Clones dotfiles, secrets, notes, and API collections repos; symlinks dotfiles via `stow` |
| 4 | Applies macOS system defaults (keyboard, dock, Finder, trackpad, etc.) |

### Scripts

| File | Purpose |
|------|---------|
| `install.sh` | Entry point |
| `helpers.sh` | Device type prompt, Homebrew install helpers |
| `create_folders.sh` | Creates standard directory structure |
| `install_and_update_homebrew.sh` | Installs or updates Homebrew |
| `install_brew_packages.sh` | Installs Homebrew formulae and casks |
| `install_brew_fonts.sh` | Installs fonts via Homebrew |
| `setup_asdf.sh` | Installs asdf plugins and tool versions |
| `setup_dotfiles.sh` | Clones the dotfiles repo |
| `setup_secrets.sh` | Clones the secrets repo |
| `setup_notes.sh` | Clones the notes repo |
| `setup_api_collections.sh` | Clones the API collections repo |
| `setup_stow.sh` | Symlinks dotfiles into `$HOME` via stow |
| `setup_mac_config.sh` | Applies macOS `defaults write` settings |
| `clean_up.sh` | Removes symlinks and cleans up |

---

## Homeserver (NixOS)

Pick **2) homeserver** at the OS prompt. Packages on the homeserver come from the nix config, so this path installs nothing: no Homebrew, asdf, fonts, or macOS defaults.

### Prerequisites

- `git`, `stow` and `ssh` provided by the nix config
- SSH key configured for GitHub

### What it does

| Stage | Description |
|-------|-------------|
| 1 | Makes all scripts executable |
| 2 | Creates the standard folders |
| 3 | Clones the dotfiles repo and symlinks it via `stow`; enables the repo's git hooks |

Not run on the homeserver: the secrets, notes and API collections clones (the homelab keeps its own notes vault), 1Password commit signing, and the direnv PAT setup. Stow links every tracked config, including macOS-only ones such as AeroSpace, which are harmless there.

---

## GitHub auth (PAT via direnv)

Cloning during install uses SSH (the key listed under Prerequisites). Day-to-day, HTTPS remotes under `~/personal/` authenticate with a PAT from `$GITHUB_PAT`, served by `.config/git/git-credential-pat` (wired in through `includeIf` blocks in `~/.gitconfig.local`, macOS only). Repos under `~/work/` do the same with a separate PAT (`gitconfig.work`). SSH remotes (`git@github.com:...`) ignore all of this and use the SSH key. Other directories are unaffected.

### Prerequisites (macOS)

- 1Password desktop app with **Settings > Developer > Integrate with 1Password CLI** enabled.
- Both 1Password accounts added to the app (`op account list` shows `my.1password.com` and `ltvco.1password.com`).
- `direnv`, `1password-cli` and `stow` are installed by `install_brew_packages.sh`, and the direnv hook (`eval "$(direnv hook zsh)"`) is already in the tracked `.zshrc`.

### On each machine

1. Run `stow . -t ~/` from the dotfiles repo (`install.sh` does this). `setup_stow.sh` also adds the `includeIf` blocks to `~/.gitconfig.local`, creates the two `.envrc` files if missing, and runs `direnv allow`. Nothing is overwritten.
2. The `.envrc` files (never commit them) name their own 1Password account and item; `git-credential-pat` reads the token when git asks, so no terminal start triggers a prompt:
   - `~/personal/.envrc`: `GITHUB_PAT_ACCOUNT=my.1password.com`, `GITHUB_PAT_REF="op://Private/GitHub PAT - Personal/token"`
   - `~/work/.envrc`: `GITHUB_PAT_ACCOUNT=ltvco.1password.com`, `GITHUB_PAT_REF="op://Employee/Github PAT - LTV/token"`
3. Remote URLs must be plain `https://github.com/<owner>/<repo>.git` (HTTPS) or `git@github.com:<owner>/<repo>.git` (SSH), with no token embedded, and no `url.*.insteadOf` rules carrying tokens.
4. Verify: `git ls-remote origin HEAD` inside a repo under `~/personal/` and one under `~/work/`.

### Token notes

- Fine-grained PATs work over HTTPS only. They expire (1 year max), so note the expiry date in the 1Password item. They cannot access GitHub Packages or `ghcr.io`; that needs a classic token with `read:packages`.
- The work token needs `ltvco` as resource owner, org approval/SSO authorization, and Contents access to each repo it must reach, including private Go modules.
