<div align="center">

<a href="">
  <img alt="Last commit" src="https://img.shields.io/github/last-commit/wchavarria03/dotfiles?logo=git&style=for-the-badge"/>
</a>

[![](https://img.shields.io/badge/Neovim-0.10.1+-blueviolet.svg?style=for-the-badge&logo=Neovim)](https://github.com/neovim/neovim)

</div>

# macOS Development Environment Setup

Complete guide for setting up a new macOS development environment with automated scripts and manual configurations.

## Index

- [Prerequisites](#prerequisites)
- [Phase 1: Initial System Setup](#phase-1-initial-system-setup)  
- [Phase 2: Homebrew & Package Management](#phase-2-homebrew--package-management)
- [Phase 3: Dotfiles & Configuration](#phase-3-dotfiles--configuration)
- [Phase 4: Development Tools Setup](#phase-4-development-tools-setup)
- [Phase 5: Authentication & Security](#phase-5-authentication--security)
- [Phase 6: Applications & Final Configuration](#phase-6-applications--final-configuration)
- [Post-Setup Verification](#post-setup-verification)
- [Troubleshooting](#troubleshooting)
- [Backup & Recovery](#backup--recovery)

## Prerequisites

Before starting the setup process, ensure you have:
- A new or freshly formatted macOS machine
- Stable internet connection (critical for Homebrew installation)
- Admin access to the machine
- GitHub account credentials

## Phase 1: Initial System Setup

### 1. macOS System Configuration

1. **Update macOS** to the latest version via System Settings
2. **Login to iCloud account** and enable synchronization
3. **Enable FileVault disk encryption** for security
4. **Install Xcode Command Line Tools:**
   ```bash
   xcode-select --install
   ```
5. **Configure Caps Lock to Control** in System Settings > Keyboard

### 2. Initial Security Setup

- **Enable FileVault encryption** (System Settings > Privacy & Security > FileVault)
- **Configure Screen Lock** to require password immediately

## Phase 2: Homebrew & Package Management

### 1. Install Homebrew

Open Safari and navigate to [brew.sh](https://brew.sh) to install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Configure Homebrew Environment

For immediate use in current session:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

**Note:** Homebrew PATH configuration will be automatically handled when you apply dotfiles in Phase 3.

## Phase 3: Dotfiles & Configuration

### 1. Initial Stow Setup

```bash
brew install stow
```

### 2. Download Dotfiles Repository

1. **Login to GitHub** in Safari
2. **Download zip file** for the dotfiles repository
3. **Extract to temporary location** (e.g., Downloads folder)

### 3. Apply Initial Dotfiles

From your downloaded dotfiles directory:

```bash
make stow
```

This creates symlinks for all configuration files to your home directory and automatically configures Homebrew paths in your shell profile.

## Phase 4: Development Tools Setup

### 1. Run Installation Script (First Attempt)

From the downloaded dotfiles directory:

```bash
cd setup
chmod +x install.sh
./install.sh
```

**Expected behavior:** The script will likely throw errors on the first run but will successfully:
- Create necessary folders (`~/personal`, `~/work`, `~/Documents/screenshots`)
- Make all scripts executable
- Attempt Homebrew package installation (may fail initially)

### 2. Manual Package Installation

If the automated script fails on packages:

```bash
chmod +x install_brew_packages.sh
./install_brew_packages.sh
```

This installs essential development tools including:
- CLI tools: `asdf`, `git`, `neovim`, `fzf`, `ripgrep`, `starship`, `zoxide`
- Applications: `1password`, `brave-browser`, `cursor`, `ghostty`, `slack`
- Development: `gh`, `lazygit`, `aerospace`, `borders`

## Phase 5: Authentication & Security

### 1. 1Password Setup

1. **Open 1Password desktop app** and complete setup
2. **Enable 1Password CLI integration:**
   - Open Ghostty terminal
   - Follow [1Password CLI integration guide](https://developer.1password.com/docs/cli/app-integration/)
3. **Configure SSH key storage** in 1Password for commit signing

### 2. Browser Configuration

1. **Open Brave browser**
2. **Enable Sync** between devices and import extensions

### 3. SSH Key Management

1. **Generate new SSH key** (if needed):
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```
2. **Upload public key to GitHub** following [GitHub's SSH guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys)
3. **Add SSH key to 1Password** for secure storage and commit signing

## Phase 6: Applications & Final Configuration

### 1. Repository Migration

1. **Run `make unstow`** in your downloaded dotfiles repo
2. **Navigate to proper location:**
   ```bash
   cd ~/personal/dotfiles
   ```
3. **Apply dotfiles from proper location:**
   ```bash
   make stow
   ```

### 2. Configure SSH Agent

```bash
ssh-add  # Add your passphrase to SSH agent
```

This allows the installation scripts to pull private repositories.

### 3. Final Installation Run

```bash
cd ~/personal/dotfiles/setup
./install.sh
```

This should now complete successfully, setting up:
- macOS system preferences optimized for development
- All remaining applications and configurations

### 4. Additional Application Setup

1. **Login to Gmail** for email access
2. **Copy `.gnupg` folder** to `~` for GPG setup (if you have existing GPG keys)
3. **Restart your computer** to ensure all configurations take effect
4. **Enable AeroSpace** window manager
5. **Login to StrongDM** (if using)
6. **Install Rodman** (if needed)
7. **Login to Slack**
8. **Connect Calendar** to email
9. **Customize Dock** - remove unnecessary apps from main bar

## Post-Setup Verification

### 1. Development Environment

```bash
# Install asdf plugins
asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
asdf plugin add python https://github.com/asdf-community/asdf-python.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install  # installs everything from .tool-versions
```

### 2. Rust Development

```bash
rustup default stable
rustup-init
echo 'export PATH="/opt/homebrew/opt/rustup/bin:$PATH"' >> ~/.config/zsh/.zshrc
```

### 3. Additional Tools

```bash
# Install map-hub package
npm install -g mcp-hub@latest

# Docker completion
mkdir -p ~/.docker/completions
docker completion zsh > ~/.docker/completions/_docker

# Brew completions
brew completions link
```

### 4. Editor Configuration

#### Neovim Setup
1. **Open Neovim** in Ghostty
2. **Setup GitHub Copilot:**
   ```vim
   :Copilot auth
   ```

#### Cursor Editor
1. **Disable macOS press-and-hold:**
   ```bash
   defaults write com.todesktop.230313mzl4w4u92 ApplePressAndHoldEnabled -bool false
   ```
2. **Copy configuration files:**
   - `cursor/keybindings.json` → Cursor settings
   - `cursor/settings.json` → Cursor settings

## Troubleshooting

### Common Issues

1. **Homebrew Installation Failures**
   - Ensure stable internet connection
   - If interrupted, uninstall all packages and restart
   - For M1/M2 Macs: Verify Homebrew path is correctly added to shell profile

2. **Script Execution Errors**
   - Run `chmod +x` on all scripts in setup folder
   - Execute scripts individually if batch execution fails
   - Check for proper directory structure in `~/personal/`

3. **SSH/Git Issues**
   - Verify SSH key is properly added to GitHub
   - Ensure SSH agent is running and key is loaded
   - Check 1Password CLI integration for commit signing

4. **Stow Conflicts**
   - Run `make unstow` before `make stow` if switching locations
   - Backup existing dotfiles before applying new ones
   - Resolve symlink conflicts manually if needed

### Performance Notes

The setup scripts include extensive macOS performance optimizations:
- Ultra-fast keyboard repeat settings
- Disabled animations for development workflow
- Optimized trackpad and mouse sensitivity
- Enhanced Finder and system responsiveness

### M1/M2 Mac Considerations

- Homebrew path configuration is critical
- Some packages may need Rosetta 2 for compatibility
- Native ARM versions are preferred when available

## Backup & Recovery

### Important Files Backed Up

- `README_BACKUP.md` - Original setup documentation

### Recovery Process

To revert to previous configuration:

1. Run `make unstow` to remove current dotfiles
2. Restore backed up configurations
3. Remove installed packages if needed using the cleanup scripts

### Cleanup Scripts

Future cleanup functionality is planned in `setup/clean_up.sh` for easy environment reset.

---

**Note:** This setup process has been tested and refined through multiple fresh macOS installations. The order of operations is critical for success - avoid skipping steps or changing the sequence.
