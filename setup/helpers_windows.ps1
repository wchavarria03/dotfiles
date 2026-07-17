# helpers_windows.ps1
# Windows equivalents of helpers.sh

$script:DEVICE_TYPE = $null

function Ensure-DeviceType {
    if ($script:DEVICE_TYPE) { return }

    Write-Host ""
    Write-Host "Which device type?"
    Write-Host "  1) personal"
    Write-Host "  2) work"
    $choice = Read-Host "> "
    switch ($choice) {
        "1" { $script:DEVICE_TYPE = "personal" }
        "2" { $script:DEVICE_TYPE = "work" }
        default { Write-Error "Invalid choice — expected 1 or 2."; exit 1 }
    }
    Write-Host "-- Device type set to: $($script:DEVICE_TYPE)" -ForegroundColor Green
    Write-Host ""
}

# Run $General always, then $Work or $Personal based on device type
function Invoke-ForDevice {
    param(
        [scriptblock]$General,
        [scriptblock]$Work,
        [scriptblock]$Personal
    )
    & $General
    if ($script:DEVICE_TYPE -eq "work") {
        & $Work
    } else {
        & $Personal
    }
}

# ── Winget helpers ────────────────────────────────────────────────────────────

function Is-WingetPackageInstalled {
    param([string]$PackageId)
    $result = winget list --id $PackageId --accept-source-agreements 2>&1
    return $result -match $PackageId
}

function Winget-Install {
    param([string[]]$PackageIds)
    foreach ($id in $PackageIds) {
        if (-not (Is-WingetPackageInstalled $id)) {
            Write-Host "Installing $id..." -ForegroundColor Green
            winget install --id $id --silent --accept-package-agreements --accept-source-agreements
        } else {
            Write-Host "$id is already installed." -ForegroundColor Green
        }
    }
}

# ── Symlink helper ────────────────────────────────────────────────────────────

# Creates a symlink at $Link pointing to $Target.
# Requires the script to run as Administrator (for mklink on Windows).
function New-Symlink {
    param(
        [string]$Target,  # source file in dotfiles repo
        [string]$Link     # destination path (e.g. $HOME\.gitconfig)
    )

    if (Test-Path $Link) {
        $item = Get-Item $Link -Force
        if ($item.LinkType -eq "SymbolicLink") {
            Write-Host "Symlink already exists: $Link" -ForegroundColor Green
            return
        } else {
            Write-Warning "File exists at $Link — skipping (not a symlink). Remove it manually to re-link."
            return
        }
    }

    $parentDir = Split-Path $Link -Parent
    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    New-Item -ItemType SymbolicLink -Path $Link -Target $Target | Out-Null
    Write-Host "Linked $Link -> $Target" -ForegroundColor Green
}
