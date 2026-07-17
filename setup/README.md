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
| 2 | Installs Git via winget, checks SSH access, clones dotfiles repo, symlinks `.gitconfig` and `.gitignore_global` |
| 3 | Installs WezTerm via winget, symlinks wezterm config from dotfiles |
| 4 | Installs Starship via winget, symlinks `starship.toml`, adds init to PowerShell profile |

### Scripts

| File | Purpose |
|------|---------|
| `install.ps1` | Entry point |
| `helpers_windows.ps1` | Device type prompt, `Winget-Install`, `New-Symlink` helpers |
| `setup_git_windows.ps1` | Git install, dotfiles clone, git config symlinks |
| `setup_wezterm_windows.ps1` | WezTerm install and config symlink |
| `setup_starship_windows.ps1` | Starship install, config symlink, PowerShell profile init |

### Notes

- Symlinks are created with `New-Item -ItemType SymbolicLink`, which requires Administrator privileges.
- If your `.gitconfig` is nested inside the dotfiles repo (e.g. under a `git/` subdirectory), update `$gitconfigSrc` in `setup_git_windows.ps1`.
- WezTerm config is detected automatically from either `~/.wezterm.lua` or `~/.config/wezterm/wezterm.lua` in the dotfiles repo.
