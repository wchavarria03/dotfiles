# setup_wezterm_windows.ps1
# Installs WezTerm and symlinks its config from the dotfiles repo.

. "$PSScriptRoot\helpers_windows.ps1"

function Setup-Wezterm {
    # Install WezTerm and the Nerd Font used by the tabbar icons (editor.lua)
    Winget-Install @("wez.wezterm", "DEVCOM.JetBrainsMonoNerdFont")

    $dotfilesPath = "$env:USERPROFILE\personal\dotfiles"

    if (-not (Test-Path $dotfilesPath)) {
        Write-Warning "Dotfiles repo not found at $dotfilesPath - run Setup-Git first."
        return
    }

    # WezTerm on Windows looks for config at %USERPROFILE%\.wezterm.lua
    # or %USERPROFILE%\.config\wezterm\wezterm.lua
    $weztermDirSrc = "$dotfilesPath\.config\wezterm"
    $weztermFileSrc = "$dotfilesPath\.wezterm.lua"

    if (Test-Path "$weztermDirSrc\wezterm.lua") {
        # wezterm.lua requires sibling modules (colors.lua, keys.lua, etc.) via
        # relative require() paths, so the whole directory must be linked -
        # symlinking just wezterm.lua leaves those requires unresolved.
        $weztermLink = "$env:USERPROFILE\.config\wezterm"

        # Clean up the stale single-file symlink left by a previous version of
        # this script, so New-Symlink can link the directory in its place.
        $existingLink = Get-Item "$weztermLink\wezterm.lua" -Force -ErrorAction SilentlyContinue
        if ((Test-Path $weztermLink) -and $existingLink -and $existingLink.LinkType -eq "SymbolicLink" -and
            (Get-ChildItem $weztermLink -Force).Count -eq 1) {
            Remove-Item $weztermLink -Force -Recurse
        }

        New-Symlink -Target $weztermDirSrc -Link $weztermLink
    } elseif (Test-Path $weztermFileSrc) {
        New-Symlink -Target $weztermFileSrc -Link "$env:USERPROFILE\.wezterm.lua"
    } else {
        Write-Warning "No wezterm config found in dotfiles repo. Checked:`n  $weztermDirSrc\wezterm.lua`n  $weztermFileSrc"
        return
    }
}
