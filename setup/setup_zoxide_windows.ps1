# setup_zoxide_windows.ps1
# Installs zoxide and wires its init into the PowerShell profile.

. "$PSScriptRoot\helpers_windows.ps1"

function Setup-Zoxide {
    Winget-Install @("ajeetdsouza.zoxide")

    # Refresh PATH so zoxide is available in this session
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("Path", "User")

    # Official zoxide-recommended init: picks the 'pwd' hook on PowerShell 6+
    # and falls back to 'prompt' on Windows PowerShell 5.1.
    $initLine = 'Invoke-Expression (& { $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { ''prompt'' } else { ''pwd'' } (zoxide init --hook $hook powershell) -join "`n" })'

    $profilePath = $PROFILE
    if (-not (Test-Path $profilePath)) {
        New-Item -ItemType File -Path $profilePath -Force | Out-Null
        Write-Host "Created PowerShell profile at $profilePath" -ForegroundColor Green
    }

    $profileContent = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue
    if ($profileContent -notmatch [regex]::Escape($initLine)) {
        Add-Content -Path $profilePath -Value "`n$initLine"
        Write-Host "Added zoxide init to $profilePath" -ForegroundColor Green
    } else {
        Write-Host "zoxide init already in profile - skipping." -ForegroundColor Green
    }
}
