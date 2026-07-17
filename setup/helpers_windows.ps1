# helpers_windows.ps1
# Windows equivalents of helpers.sh

$script:OS_TYPE = $null
$script:DEVICE_TYPE = $null

function Ensure-OsType {
    if ($script:OS_TYPE) { return }

    Write-Host ""
    Write-Host "Which OS?"
    Write-Host "  1) mac"
    Write-Host "  2) windows"
    $choice = Read-Host "> "
    switch ($choice) {
        "1" { $script:OS_TYPE = "mac" }
        "2" { $script:OS_TYPE = "windows" }
        Default { throw "Invalid choice - expected 1 or 2." }
    }
    Write-Host "-- OS type set to: $($script:OS_TYPE)" -ForegroundColor Green
    Write-Host ""
}

function Invoke-ForOs {
    param(
        [scriptblock]$General,
        [scriptblock]$Mac,
        [scriptblock]$Windows
    )
    & $General
    if ($script:OS_TYPE -eq "mac") {
        & $Mac
    } else {
        & $Windows
    }
}

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
        Default { throw "Invalid choice - expected 1 or 2." }
    }
    Write-Host "-- Device type set to: $($script:DEVICE_TYPE)" -ForegroundColor Green
    Write-Host ""
}

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

function New-Symlink {
    param(
        [string]$Target,
        [string]$Link
    )

    if (-not $Link) {
        throw "New-Symlink: Link parameter is null or empty."
    }

    if (Test-Path $Link) {
        $item = Get-Item $Link -Force
        if ($item.LinkType -eq "SymbolicLink") {
            Write-Host "Symlink already exists: $Link" -ForegroundColor Green
            return
        } else {
            Write-Warning "File exists at $Link - skipping. Remove it manually to re-link."
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
