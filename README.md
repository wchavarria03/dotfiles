<div align="center">

<a href="">
  <img alt="Last commit" src="https://img.shields.io/github/last-commit/wchavarria03/dotfiles?logo=git&style=for-the-badge"/>
</a>

[![](https://img.shields.io/badge/Neovim-0.10.1+-blueviolet.svg?style=for-the-badge&logo=Neovim)](https://github.com/neovim/neovim)

</div>

# macOS Development Environment Setup

Complete guide for setting up a new macOS development environment with automated scripts and manual configurations.

## Index

- [Setup Architecture](#setup-architecture)
- [Prerequisites](#prerequisites)
- [Phase 1: Initial System Setup](#phase-1-initial-system-setup)
- [Phase 2: Homebrew Bootstrap](#phase-2-homebrew-bootstrap)
- [Phase 3: SSH & Repository Setup](#phase-3-ssh--repository-setup)
- [Phase 4: Run Installation Script](#phase-4-run-installation-script)
- [Phase 5: Authentication & Security](#phase-5-authentication--security)
- [Phase 6: Final Configuration](#phase-6-final-configuration)
- [Post-Setup Verification](#post-setup-verification)
- [Troubleshooting](#troubleshooting)

---

## Setup Architecture

The `setup/` directory follows a consistent pattern across all scripts. Each script exposes three functions and a public entry point:

```bash
general_*()   # always runs — shared across all devices
work_*()      # runs when DEVICE_TYPE=work
personal_*()  # runs when DEVICE_TYPE=personal

public_fn() {
    source helpers.sh && ensure_device_type
    run_for_device general_* work_* personal_*
}
```

`helpers.sh` provides `ensure_device_type` (prompts once if `DEVICE_TYPE` is unset) and `run_for_device` (the dispatcher). Scripts that need brew helpers (`brew_install_formulae`, `brew_install_casks`) also pull those from `helpers.sh`.

**Scripts that follow this pattern:**

| Script | Customizable via |
|---|---|
| `install_brew_packages.sh` | `general/work/personal_packages()` |
| `install_brew_fonts.sh` | `general/work/personal_fonts()` |
| `setup_mac_config.sh` | `general/work/personal_mac_config()` |
| `setup_asdf.sh` | `general/work/personal_asdf()` |
| `create_folders.sh` | `general/work/personal_folders()` |
| `setup_api_collections.sh` | `general/work/personal_api_collections()` |

To add a device-specific package, font, folder, or config — open the relevant script and edit the `work_*` or `personal_*` function. No other files need to change.

**Current device extras:**
- `work`: `claude-code`
- `personal`: `opencode`

---

## Prerequisites

- A new or freshly formatted macOS machine
- Stable internet connection
- Admin access to the machine
- GitHub account credentials

---

## Phase 1: Initial System Setup

1. **Update macOS** to the latest version via System Settings
2. **Login to iCloud** and enable synchronization
3. **Enable FileVault** (System Settings > Privacy & Security > FileVault)
4. **Configure Screen Lock** to require password immediately
5. **Install Xcode Command Line Tools:**
   ```bash
   xcode-select --install
   ```
6. **Configure Caps Lock to Control** in System Settings > Keyboard

---

## Phase 2: Homebrew Bootstrap

Install Homebrew manually — this is the only step that can't be automated:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Make it available in the current session:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Then install `stow` and clone the dotfiles so the install script is available:

```bash
brew install stow
git clone git@github.com:wchavarria03/dotfiles.git ~/personal/dotfiles
cd ~/personal/dotfiles && make stow
```

`make stow` symlinks `~/.config` and other dotfiles to this repo, which also wires up the Homebrew PATH for future sessions.

---

## Phase 3: SSH & Repository Setup

Set up SSH keys before running the install script — Stage 3 clones private repos over SSH and will skip them if keys aren't configured.

1. **Generate a new SSH key:**
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```
2. **Add it to GitHub** following [GitHub's SSH guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
3. **Add it to 1Password** for secure storage and commit signing
4. **Load the key into the agent:**
   ```bash
   ssh-add
   ```
5. **Verify access:**
   ```bash
   ssh -T git@github.com
   ```

---

## Phase 4: Run Installation Script

```bash
cd ~/personal/dotfiles/setup
./install.sh
```

The script will prompt for device type (`personal` or `work`) on first run and export `DEVICE_TYPE` for all subsequent steps. Individual scripts can also be run standalone — they will prompt for device type if the variable isn't set.

**What the script does:**

| Stage | Steps |
|---|---|
| 1 | Makes all scripts executable, prompts for device type |
| 2 | Creates folders, installs Homebrew packages + fonts, sets up asdf plugins and tool versions |
| 3 | Checks SSH access, clones/pulls secrets, dotfiles, notes, and API collections repos, runs `stow` |
| 4 | Applies macOS system defaults |

If SSH isn't configured when Stage 3 runs, it prints a warning and skips repo cloning — re-run the script after setting up SSH keys.

---

## Phase 5: Authentication & Security

1. **Open 1Password** and complete setup
2. **Enable 1Password CLI integration** — open WezTerm and follow the [1Password CLI guide](https://developer.1password.com/docs/cli/app-integration/)
3. **Open Brave browser**, enable Sync, and import extensions
4. **Copy `.gnupg` folder** to `~` if you have existing GPG keys

---

## Phase 6: Final Configuration

1. **Restart** to ensure all macOS defaults take effect
2. **Enable AeroSpace** window manager
3. **Open Neovim** — plugins install automatically on first launch
4. **Authenticate GitHub Copilot** in Neovim:
   ```vim
   :Copilot auth
   ```
5. **Disable press-and-hold in Cursor** for key repeat:
   ```bash
   defaults write com.todesktop.230313mzl4w4u92 ApplePressAndHoldEnabled -bool false
   ```
6. **Connect Calendar** to email and configure Dock

---

## Post-Setup Verification

### Rust

```bash
rustup default stable
```

### npm globals

```bash
npm install -g mcp-hub@latest
```

### Docker completion

```bash
mkdir -p ~/.docker/completions
docker completion zsh > ~/.docker/completions/_docker
brew completions link
```

---

## Troubleshooting

**Homebrew failures**
- Ensure stable internet connection
- For Apple Silicon: verify `eval "$(/opt/homebrew/bin/brew shellenv)"` ran before the script

**SSH / repo cloning skipped**
- The install script checks SSH access before Stage 3 and skips with a clear message if keys aren't configured
- Set up keys (Phase 3) and re-run `./install.sh`

**Stow conflicts**
- Run `make unstow` then `make stow` to re-apply symlinks
- Resolve conflicts manually if a file already exists at the target path

**Script errors**
- Each script can be run individually from the `setup/` directory
- If `DEVICE_TYPE` isn't set, the script will prompt before continuing

**Apple Silicon notes**
- Homebrew installs to `/opt/homebrew` — PATH must be configured before any brew commands
- Native ARM binaries are used by default; Rosetta 2 is only needed for specific apps
