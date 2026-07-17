# setup_git_windows.ps1
# Installs Git, clones dotfiles, and symlinks git config on Windows.

. "$PSScriptRoot\helpers_windows.ps1"

function Setup-Git {
    # Install Git for Windows
    Winget-Install @("Git.Git")

    # Refresh PATH so git is available in this session
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("Path", "User")

    # ── SSH check ────────────────────────────────────────────────────────────
    Write-Host "Checking SSH access to GitHub..." -ForegroundColor Green
    $sshTest = ssh -T git@github.com 2>&1
    if ($sshTest -notmatch "successfully authenticated") {
        Write-Warning "SSH key not configured for GitHub."
        Write-Host "Generate a key with:  ssh-keygen -t ed25519 -C 'your@email.com'"
        Write-Host "Then add the public key at https://github.com/settings/ssh/new"
        Write-Host "Re-run this script after setting up SSH."
        return
    }

    # ── Clone or update dotfiles ──────────────────────────────────────────────
    $dotfilesPath = "$env:USERPROFILE\personal\dotfiles"
    if (-not (Test-Path $dotfilesPath)) {
        Write-Host "Cloning dotfiles repo..." -ForegroundColor Green
        git clone git@github.com:wchavarria03/dotfiles.git $dotfilesPath
    } else {
        Write-Host "Updating dotfiles repo..." -ForegroundColor Green
        git -C $dotfilesPath pull
    }

    # ── Symlink git config ────────────────────────────────────────────────────
    # Adjust the source path if your .gitconfig lives elsewhere in the dotfiles repo
    $gitconfigSrc = "$dotfilesPath\.gitconfig"
    if (Test-Path $gitconfigSrc) {
        New-Symlink -Target $gitconfigSrc -Link "$env:USERPROFILE\.gitconfig"
    } else {
        Write-Warning ".gitconfig not found in dotfiles repo at $gitconfigSrc — skipping symlink."
    }

    # Also link .gitignore_global if present
    $gitignoreSrc = "$dotfilesPath\.gitignore_global"
    if (Test-Path $gitignoreSrc) {
        New-Symlink -Target $gitignoreSrc -Link "$env:USERPROFILE\.gitignore_global"
    }
}
