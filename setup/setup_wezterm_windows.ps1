# setup_wezterm_windows.ps1
# Installs WezTerm and symlinks its config from the dotfiles repo.

. "$PSScriptRoot\helpers_windows.ps1"

function Setup-Wezterm {
    # Install WezTerm
    Winget-Install @("wez.wezterm")

    $dotfilesPath = "$env:USERPROFILE\personal\dotfiles"

    if (-not (Test-Path $dotfilesPath)) {
        Write-Warning "Dotfiles repo not found at $dotfilesPath — run Setup-Git first."
        return
    }

    # WezTerm on Windows looks for config at %USERPROFILE%\.wezterm.lua
    # or %USERPROFILE%\.config\wezterm\wezterm.lua
    # Try both common locations in the dotfiles repo.
    $candidates = @(
        "$dotfilesPath\.wezterm.lua",
        "$dotfilesPath\.config\wezterm\wezterm.lua"
    )

    $weztermSrc = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1

    if (-not $weztermSrc) {
        Write-Warning "No wezterm config found in dotfiles repo. Checked:`n  $($candidates -join "`n  ")"
        return
    }

    # Symlink to the location WezTerm expects on Windows
    if ($weztermSrc -like "*\.wezterm.lua") {
        New-Symlink -Target $weztermSrc -Link "$env:USERPROFILE\.wezterm.lua"
    } else {
        New-Symlink -Target $weztermSrc -Link "$env:USERPROFILE\.config\wezterm\wezterm.lua"
    }
}
