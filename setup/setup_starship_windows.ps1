# setup_starship_windows.ps1
# Installs Starship prompt, symlinks its config, and wires it into the PowerShell profile.

. "$PSScriptRoot\helpers_windows.ps1"

function Setup-Starship {
    # Install Starship
    Winget-Install @("Starship.Starship")

    # Refresh PATH so starship is available in this session
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("Path", "User")

    $dotfilesPath = "$env:USERPROFILE\personal\dotfiles"

    # ── Symlink starship config ───────────────────────────────────────────────
    $starshipSrc = "$dotfilesPath\.config\starship.toml"
    if (Test-Path $starshipSrc) {
        New-Symlink -Target $starshipSrc -Link "$env:USERPROFILE\.config\starship.toml"
    } else {
        Write-Warning "starship.toml not found in dotfiles at $starshipSrc — skipping symlink."
    }

    # ── Add init to PowerShell profile ───────────────────────────────────────
    $initLine = 'Invoke-Expression (&starship init powershell)'

    $profilePath = $PROFILE
    if (-not (Test-Path $profilePath)) {
        New-Item -ItemType File -Path $profilePath -Force | Out-Null
        Write-Host "Created PowerShell profile at $profilePath" -ForegroundColor Green
    }

    $profileContent = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue
    if ($profileContent -notmatch [regex]::Escape($initLine)) {
        Add-Content -Path $profilePath -Value "`n$initLine"
        Write-Host "Added Starship init to $profilePath" -ForegroundColor Green
    } else {
        Write-Host "Starship init already in profile — skipping." -ForegroundColor Green
    }
}
