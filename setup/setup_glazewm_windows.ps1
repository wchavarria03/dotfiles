# setup_glazewm_windows.ps1
# Installs GlazeWM (i3-style tiling window manager) and symlinks its config
# from the dotfiles repo. Windows analog of the aerospace setup on Mac.

. "$PSScriptRoot\helpers_windows.ps1"

function Setup-GlazeWM {
    Winget-Install @("glzr-io.glazewm")

    $dotfilesPath = "$env:USERPROFILE\personal\dotfiles"

    if (-not (Test-Path $dotfilesPath)) {
        Write-Warning "Dotfiles repo not found at $dotfilesPath - run Setup-Git first."
        return
    }

    $glazewmSrc = "$dotfilesPath\.config\glazewm\config.yaml"
    if (Test-Path $glazewmSrc) {
        # GlazeWM only reads a single config.yaml (no sibling requires like
        # WezTerm's Lua config), so linking the file itself is sufficient.
        New-Symlink -Target $glazewmSrc -Link "$env:USERPROFILE\.glzr\glazewm\config.yaml"
    } else {
        Write-Warning "glazewm config.yaml not found at $glazewmSrc - skipping symlink."
    }
}
