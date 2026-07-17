# setup_starship_windows.ps1
# Installs Starship prompt, symlinks its config, and wires it into the PowerShell profile.

. "$PSScriptRoot\helpers_windows.ps1"

function Setup-Starship {
    # Install Starship
    Winget-Install @("Starship.Starship")

    # Refresh PATH so starship is available in this session
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("Path", "User")

    $dotfilesPath = "$HOME\personal\dotfiles"

    # ── Symlink starship config ───────────────────────────────────────────────
    $starshipSrc = "$dotfilesPath\.config\starship.toml"
    if (Test-Path $starshipSrc) {
        New-Symlink -Target $starshipSrc -Link "$HOME\.config\starship.toml"
    } else {
        Write-Warning "starship.toml not found in dotfiles at $starshipSrc — skipping symlink."
    }

    # ── Add init to PowerShell profile ───────────────────────────────────────
    $initLine = 'Invoke-Expression (&starship init powershell)'

    if (-not (Test-Path $PROFILE)) {
        New-Item -ItemType File -Path $PROFILE -Force | Out-Null
        Write-Host "Created PowerShell profile at $PROFILE" -ForegroundColor Green
    }

    $profileContent = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue
    if ($profileContent -notmatch [regex]::Escape($initLine)) {
        Add-Content -Path $PROFILE -Value "`n$initLine"
        Write-Host "Added Starship init to $PROFILE" -ForegroundColor Green
    } else {
        Write-Host "Starship init already in profile — skipping." -ForegroundColor Green
    }
}
