# Machine Setup

Bootstrap scripts for setting up a new machine. Idempotent — safe to run multiple times.

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

## Windows

Covers Git integration and WezTerm configuration. Uses `winget` for package management and PowerShell symlinks instead of `stow`.

### Prerequisites

- Windows 10 1709+ or Windows 11 (winget required)
- PowerShell 5.1+ or PowerShell 7+
- Run as **Administrator** (required for creating symlinks)
- SSH key configured for GitHub (see below)

### SSH Setup

SSH must be configured before running the install script — it's needed to clone the dotfiles repo.

**1. Install Git** (skip if already installed):

```cmd
winget install --id Git.Git --silent --accept-package-agreements
```

Restart your terminal so `ssh-keygen` is on PATH.

**2. Generate a key:**

```cmd
ssh-keygen -t ed25519 -C "your@email.com"
```

Accept the default path (`~/.ssh/id_ed25519`) and set a passphrase if desired.

**3. Copy the public key:**

In Command Prompt:
```cmd
type %USERPROFILE%\.ssh\id_ed25519.pub | clip
```

In Git Bash:
```bash
cat ~/.ssh/id_ed25519.pub | clip
```

**4.** Paste it at https://github.com/settings/ssh/new

**5. Verify:**

```cmd
ssh -T git@github.com
# Hi wchavarria03! You've successfully authenticated...
```

### Usage

**1. Clone the dotfiles repo:**

```cmd
git clone git@github.com:wchavarria03/dotfiles.git %USERPROFILE%\personal\dotfiles
```

**2. Run the install script** from Command Prompt as Administrator:

```cmd
powershell -ExecutionPolicy Bypass -File "%USERPROFILE%\personal\dotfiles\setup\install.ps1"
```

### What it does

| Stage | Description |
|-------|-------------|
| 1 | Loads helpers, prompts for device type |
| 2 | Installs Git via winget, checks SSH access, clones dotfiles/notes/secrets repos, symlinks `.gitconfig`, `.gitignore_global`, and nvim config |
| 3 | Installs WezTerm via winget, symlinks the whole `.config/wezterm` directory from dotfiles, installs the JetBrainsMono Nerd Font |
| 4 | Installs Starship via winget, symlinks `starship.toml`, adds init to PowerShell profile |
| 5 | Installs GlazeWM via winget, symlinks `.config/glazewm/config.yaml` |
| 6 | Installs zoxide via winget, adds init to PowerShell profile |
| 7 | Installs extras with no dotfiles-managed config: ripgrep, fzf, imagemagick, glow, PowerToys, Brave |

### Scripts

| File | Purpose |
|------|---------|
| `install.ps1` | Entry point |
| `helpers_windows.ps1` | Device type prompt, `Winget-Install`, `New-Symlink` helpers |
| `setup_git_windows.ps1` | Git install, dotfiles/notes clone, git config and nvim symlinks |
| `setup_wezterm_windows.ps1` | WezTerm install and config directory symlink |
| `setup_starship_windows.ps1` | Starship install, config symlink, PowerShell profile init |
| `setup_glazewm_windows.ps1` | GlazeWM install and config symlink |
| `setup_zoxide_windows.ps1` | zoxide install, PowerShell profile init |
| `setup_extras_windows.ps1` | ripgrep, fzf, imagemagick, glow, PowerToys, Brave |

### Notes

- Symlinks are created with `New-Item -ItemType SymbolicLink`, which requires Administrator privileges — run the install command from an elevated Command Prompt (or an admin Run dialog/shortcut). `powershell -ExecutionPolicy Bypass -File ...` does **not** self-elevate; it only bypasses the script execution policy, not `#Requires -RunAsAdministrator`.
- `%USERPROFILE%` in the commands above is `cmd.exe` syntax. It's expanded by Command Prompt before `powershell.exe` ever sees it, so paste these into Command Prompt (or a shortcut's Target field), not directly into an already-open PowerShell window — there it'd need to be `$env:USERPROFILE` instead.
- If your `.gitconfig` is nested inside the dotfiles repo (e.g. under a `git/` subdirectory), update `$gitconfigSrc` in `setup_git_windows.ps1`.
- WezTerm config is detected automatically from either `~/.wezterm.lua` or `~/.config/wezterm/wezterm.lua` in the dotfiles repo. Since `wezterm.lua` `require()`s sibling modules (`colors.lua`, `keys.lua`, etc.), the whole `.config/wezterm` directory is symlinked, not just the one file.
- `.ps1` files in this repo must not contain non-ASCII characters (em dashes, curly quotes) inside string literals — files have no BOM, so Windows PowerShell 5.1 reads them via the system ANSI codepage, and an em dash can get misread as a string-terminating curly quote, breaking the parser.
- GlazeWM's `window_rules` in `.config/glazewm/config.yaml` match by process name — verify exact `.exe` names via Task Manager's Details tab for apps not yet confirmed (see comments in the file).

## GitHub auth (PAT via direnv)

Cloning during install uses SSH (the key listed under Prerequisites). Day-to-day, HTTPS remotes under `~/personal/` authenticate with a PAT from `$GITHUB_PAT`, served by `.config/git/git-credential-pat` (wired in through `includeIf` blocks in `~/.gitconfig.local`, macOS only). Repos under `~/work/` do the same with a separate PAT (`gitconfig.work`). SSH remotes (`git@github.com:...`) ignore all of this and use the SSH key. Other directories are unaffected.

### Prerequisites (macOS)

- 1Password desktop app with **Settings > Developer > Integrate with 1Password CLI** enabled.
- Both 1Password accounts added to the app (`op account list` shows `my.1password.com` and `ltvco.1password.com`).
- `direnv`, `1password-cli` and `stow` are installed by `install_brew_packages.sh`, and the direnv hook (`eval "$(direnv hook zsh)"`) is already in the tracked `.zshrc`.

### On each machine

1. Run `stow . -t ~/` from the dotfiles repo (`install.sh` does this). `setup_stow.sh` also adds the `includeIf` blocks to `~/.gitconfig.local`, creates the two `.envrc` files if missing, and runs `direnv allow`. Nothing is overwritten.
2. The `.envrc` files (never commit them) each read their own 1Password account, so `op` must be signed in to both:
   - `~/personal/.envrc`: `export GITHUB_PAT=$(op read --account my.1password.com "op://Private/GitHub PAT - Personal/token")`
   - `~/work/.envrc`: `export GITHUB_PAT=$(op read --account ltvco.1password.com "op://Employee/Github PAT - LTV/token")`
3. Remote URLs must be plain `https://github.com/<owner>/<repo>.git` (HTTPS) or `git@github.com:<owner>/<repo>.git` (SSH), with no token embedded, and no `url.*.insteadOf` rules carrying tokens.
4. Verify: `git ls-remote origin HEAD` inside a repo under `~/personal/` and one under `~/work/`.

### Windows

Windows keeps Git Credential Manager over HTTPS for `notes` and `streaming`, with no direnv or `op`. The PAT setup above is not applied there because it lives in `~/.gitconfig.local`, which the Windows setup doesn't create.

### Token notes

- Fine-grained PATs work over HTTPS only. They expire (1 year max), so note the expiry date in the 1Password item. They cannot access GitHub Packages or `ghcr.io`; that needs a classic token with `read:packages`.
- The work token needs `ltvco` as resource owner, org approval/SSO authorization, and Contents access to each repo it must reach, including private Go modules.
