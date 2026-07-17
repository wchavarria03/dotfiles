# setup_git_windows.ps1
# Installs Git, clones repos, and symlinks configs on Windows.

. "$PSScriptRoot\helpers_windows.ps1"

function Setup-Git {
    Winget-Install @("Git.Git")

    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("Path", "User")

    Write-Host "Checking SSH access to GitHub..." -ForegroundColor Green
    $sshTest = ssh -T git@github.com 2>&1
    if ($sshTest -notmatch "successfully authenticated") {
        Write-Warning "SSH key not configured for GitHub."
        Write-Host "Generate a key with: ssh-keygen -t ed25519 -C your@email.com"
        Write-Host "Then add the public key at https://github.com/settings/ssh/new"
        Write-Host "Re-run this script after setting up SSH."
        return
    }

    $personalPath = "$env:USERPROFILE\personal"

    $dotfilesPath = "$personalPath\dotfiles"
    if (-not (Test-Path $dotfilesPath)) {
        Write-Host "Cloning dotfiles repo..." -ForegroundColor Green
        git clone git@github.com:wchavarria03/dotfiles.git $dotfilesPath
    } else {
        Write-Host "Updating dotfiles repo..." -ForegroundColor Green
        git -C $dotfilesPath pull
    }

    $notesPath = "$personalPath\notes"
    if (-not (Test-Path $notesPath)) {
        Write-Host "Cloning notes repo..." -ForegroundColor Green
        git clone git@github.com:wchavarria03/notes.git $notesPath
        git -C $notesPath lfs install
        git -C $notesPath lfs pull
    } else {
        Write-Host "Updating notes repo..." -ForegroundColor Green
        git -C $notesPath pull
    }

    $gitconfigSrc = "$dotfilesPath\.gitconfig"
    if (Test-Path $gitconfigSrc) {
        New-Symlink -Target $gitconfigSrc -Link "$env:USERPROFILE\.gitconfig"
    } else {
        Write-Warning ".gitconfig not found at $gitconfigSrc - skipping."
    }

    $gitignoreSrc = "$dotfilesPath\.gitignore_global"
    if (Test-Path $gitignoreSrc) {
        New-Symlink -Target $gitignoreSrc -Link "$env:USERPROFILE\.gitignore_global"
    }

    $nvimSrc = "$dotfilesPath\.config\nvim"
    if (Test-Path $nvimSrc) {
        New-Symlink -Target $nvimSrc -Link "$env:LOCALAPPDATA\nvim"
    } else {
        Write-Warning "nvim config not found at $nvimSrc - skipping."
    }
}
