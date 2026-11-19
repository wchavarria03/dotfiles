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
- [Notes](#notes)
- [Post-Setup Verification](#post-setup-verification)
- [Aegis Development Environment](#aegis-development-environment)
- [Aegis Herdr Configuration](#aegis-herdr-configuration)
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

| Script                     | Customizable via                          |
| -------------------------- | ----------------------------------------- |
| `install_brew_packages.sh` | `general/work/personal_packages()`        |
| `install_brew_fonts.sh`    | `general/work/personal_fonts()`           |
| `setup_mac_config.sh`      | `general/work/personal_mac_config()`      |
| `setup_asdf.sh`            | `general/work/personal_asdf()`            |
| `create_folders.sh`        | `general/work/personal_folders()`         |
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

| Stage | Steps                                                                                            |
| ----- | ------------------------------------------------------------------------------------------------ |
| 1     | Makes all scripts executable, prompts for device type                                            |
| 2     | Creates folders, installs Homebrew packages + fonts, sets up asdf plugins and tool versions, checks Aegis dev tooling |
| 3     | Checks SSH access, clones/pulls secrets, dotfiles, notes, and API collections repos, runs `stow` |
| 4     | Applies macOS system defaults                                                                    |

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
4. **Open the notes vault** with `alt-p` (see [Notes](#notes))
5. **Disable press-and-hold in Cursor** for key repeat:
   ```bash
   defaults write com.todesktop.230313mzl4w4u92 ApplePressAndHoldEnabled -bool false
   ```
6. **Connect Calendar** to email and configure Dock

---

## Notes

Notes and code both live in the one Neovim config now (`.config/nvim`); WezTerm windows are routed to a workspace by title, no daemons involved:

| Key | What |
|-----|------|
| `alt-p` | Notes Nvim (workspace `p`), the Markdown vault in `~/personal/notes`, via `obsidian.nvim` |
| `alt-e` | Code Nvim (workspace `e`) |
| `alt-shift-n` | Floating quick-capture: appends to the notes inbox (`ideas_todos.md`), `:wq` to save and close |

Vault config: `.config/nvim/lua/plugins/obsidian.lua`. Launchers: `.config/aerospace/launch_notes_nvim.sh`, `launch_code_nvim.sh`, `launch_notes_capture.sh`.

The Obsidian GUI app (installed via brew cask, same vault path) is kept around only for its graph view — `obsidian.nvim` has no visual graph UI, so open the app whenever navigating the backlink graph matters more than editing.

- **Spell checking:** aspell, English plus Spanish if `aspell dicts` lists `es`. In Neovim: `z =` suggestions, `z g` add word, `z w` mark as wrong.
- **Google Calendar sync:** dropped along with org-gcal (Emacs retired 2026-11-08) — no Neovim-native equivalent pursued. Check Google Calendar separately.

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

## Aegis Development Environment

Dev environment setup for [Aegis](https://github.com/wchavarria03/aegis), provisioned by `setup/setup_aegis_dev.sh` (runs automatically in Stage 2 of `install.sh`, after asdf).

**Minimum supported environment:**

| Tool | Version | Source |
|------|---------|--------|
| macOS | current version supported by [Homebrew](https://docs.brew.sh/Installation) | manual, Phase 1 |
| Python | 3.14.9 | pinned in `.tool-versions`, installed via asdf |
| Git | latest via Homebrew | `install_brew_packages.sh` |
| Package manager | Homebrew | this repo's bootstrap |

**Python dependency/project workflow:** [`uv`](https://docs.astral.sh/uv/) — pinned in `.tool-versions` and installed via asdf, consistent with how this repo already manages Python/Node/Go/Rust. Aegis's own `pyproject.toml`/lockfile conventions are defined in the aegis repo itself; this repo only guarantees a pinned `uv` is present.

**Formatting, linting, type-checking, tests:**

| Concern | Tool | Installed via |
|---------|------|----------------|
| Format + lint | [`ruff`](https://docs.astral.sh/ruff/) | Homebrew (not asdf — see note below) |
| Type-checking | [`mypy`](https://mypy-lang.org/) | `uv tool install`, via `setup_aegis_dev.sh` |
| Tests | [`pytest`](https://docs.pytest.org/) | `uv tool install`, via `setup_aegis_dev.sh` |

`ruff` stays on Homebrew rather than asdf: the [asdf-ruff](https://github.com/simhem/asdf-ruff) plugin has an unresolved macOS install-path bug ([simhem/asdf-ruff#12](https://github.com/simhem/asdf-ruff/issues/12), open since April 2025) where the binary is extracted to the wrong path on both Intel and Apple Silicon, so installs fail on exactly the platform this repo targets. Homebrew formulae float to whatever's current rather than giving an exact pin, but that's an acceptable trade here versus depending on a broken plugin — revisit if the upstream bug is fixed. `uv` has no such issue: [asdf-uv](https://github.com/asdf-community/asdf-uv) correctly handles both `arm64`/`aarch64` and `apple-darwin` and is actively maintained.

`mypy` and `pytest` are installed as `uv` tools rather than asdf plugins or Homebrew formulae — they're Python-ecosystem packages, not standalone binaries, so they're best kept in sync with `uv` itself. `uv tool install` keeps them user-space with no sudo required.

**Manual prerequisites / recovery:**

- `setup_aegis_dev.sh` only checks for and reports missing tools (`uv`, `ruff`, `python`, `git`) — it does not install them itself. If any are missing, it prints what's missing and exits non-zero; run `setup_asdf.sh` (for `uv`) and `install_brew_packages.sh` (for `ruff`) first, then re-run `setup_aegis_dev.sh`.
- Safe to re-run any time — checks are read-only and `uv tool install` is idempotent (no-ops if already installed at the same version).
- If `uv tool install` fails for `mypy` or `pytest` (e.g. no network), re-run `setup_aegis_dev.sh` once connectivity is restored — nothing else in the repo depends on them being present.

---

## Aegis Herdr Configuration

[Herdr](https://herdr.dev) keeps AI coding agent sessions (Claude Code, opencode) alive across disconnects. This setup uses only the desktop app (`herdr-app`, a GUI) and `herdr-core` (`hc`), the headless daemon it runs on. The `herdr` TUI is not installed: it runs its own separate session server, so workspaces created through its CLI never appear in the app.

**Portable vs. machine-specific config:**

- `.config/herdr-app/settings.json` and `keys.json` are tracked (plus `programs.json` if it ever exists). Herdr rewrites everything else in that folder on every start (shipped mods, layouts, icons, typings) or keeps per-machine state there (`view.json`, `window.json`, `shared.json`, `data/`, `telemetry/`), so the rest is ignored via `.gitignore`.
- To customize a layout, mod or theme, clone the shipped one first (`herdr-app do layout.clone '{"name":"main","as":"my-layout"}'`), then add a `!` line for the clone to `.gitignore`.
- `.config/herdr/` is ignored only to hide leftovers from the removed TUI.

**Credentials — herdr never holds them:**

Herdr is a terminal workspace manager, not an LLM client. Panes inherit the ambient environment of the shell that launches them, and each agent manages its own auth independently:

| Agent | Where its credentials come from |
|-------|----------------------------------|
| Claude Code | its own `claude login` / Anthropic auth, outside this repo |
| opencode | its own provider config (e.g. `~/.config/opencode/`), outside the files this repo tracks |

This repo's existing convention for any real secret (see [Phase 3](#phase-3-ssh--repository-setup) and `setup_stow.sh`'s `ensure_github_envrc`) is: never commit a token, always resolve it from 1Password at shell-init time via `.envrc` + `op read`. If an Aegis agent backend ever needs its own API key sourced through this repo rather than through its native login flow, follow that same pattern — a `.envrc` entry reading from 1Password (`op read --account <account> "op://<vault>/<item>/token"`), never a literal key in a tracked file.

**`herdr-core` (`hc`) and waiting on independent peer terminals:**

[`herdr-core`](https://herdr.dev) (`hc`) is the headless daemon the Herdr desktop and mobile apps talk to. It supports send/read delegation between terminals via `hc send`/`hc read`.

`hc wait <terminal>` only auto-detects "turn completed" for terminals in a true parent-child relationship (one `hc` terminal launched from within another via `hc run --bg`, waited on with `hc wait --children`). For independent peer terminals — the setup used to keep each project as its own top-level space rather than nesting everything under one parent — plain `hc wait` times out even after the agent has clearly finished responding.

`bin/hc-wait-idle.sh <terminal> [quiet_seconds=2] [max_seconds=180]` works around this for any terminal, parent/child or not: it watches `hc events --terminal <t> --json`, which fires correctly regardless of relationship, and treats a quiet period (no new events for `quiet_seconds`) as "settled." Symlinked onto `PATH` via `stow` (same as everything else under `bin/`), so it's callable directly as `hc-wait-idle.sh` once stowed.

**`herdr-app` (desktop GUI):**

Installed by default (`brew install --cask herdr-app`, in `general_packages`'s casks — not conditional on device type). It's the desktop counterpart to the Herdr mobile app and talks to `herdr-core`. Two uses:

- Lets the mobile app reach this Mac's own `herdr-core` sessions at any time.
- Lets this Mac's GUI act as a client to nix-homelab's `herdr-core`, over the same SSH machine registration already used for the mobile app.

Apple Silicon only — the cask has no Intel build. This repo has no existing Mac arch-level split to match (no Intel-vs-arm64 branching anywhere in `install_brew_packages.sh`), so this is a flat addition; if an Intel Mac ever needs to run this setup, `herdr-app` will fail to install and need to be skipped or built from source.

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
