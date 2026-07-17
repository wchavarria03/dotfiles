# setup_git_windows.ps1
# Installs Git, clones repos, and symlinks configs on Windows.

. "$PSScriptRoot\helpers_windows.ps1"

function Setup-Git {
    Winget-Install @("Git.Git")

    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("Path", "User")

    Write-Host "Checking SSH access to GitHub..." -ForegroundColor Green
    $sshTest = & {
        $ErrorActionPreference = "Continue"
        ssh -T git@github.com 2>&1
    } | Out-String
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

    # Streaming folders - personal streaming PC only (needs a D: drive with
    # the Streaming folder layout). Assets symlinks to the notes repo (single
    # source of truth for GIMP .xcf sources); Exports is a real, unsynced
    # folder for disposable one-off renders - mirrors create_folders.sh /
    # setup_notes.sh on the Mac side.
    if (Test-Path "D:\") {
        New-Symlink -Target "$notesPath\attachments\streaming" -Link "D:\Streaming\Assets"

        $exportsPath = "D:\Streaming\Exports"
        if (-not (Test-Path $exportsPath)) {
            New-Item -ItemType Directory -Path $exportsPath -Force | Out-Null
            Write-Host "-- Created folder: $exportsPath" -ForegroundColor Green
        }
    } else {
        Write-Host "No D: drive found - skipping streaming folders." -ForegroundColor Yellow
    }

    $secretsPath = "$personalPath\secrets"
    if (-not (Test-Path $secretsPath)) {
        Write-Host "Cloning secrets repo..." -ForegroundColor Green
        git clone git@github.com:wchavarria03/secrets.git $secretsPath
    } else {
        Write-Host "Updating secrets repo..." -ForegroundColor Green
        git -C $secretsPath pull
    }

    $gitconfigSrc = "$dotfilesPath\.gitconfig"
    if (Test-Path $gitconfigSrc) {
        $gitconfigLink = "$env:USERPROFILE\.gitconfig"

        # `git lfs install` (run above, before this repo existed on disk to
        # symlink) writes a global config stub containing only the LFS
        # filter block, which is already tracked in the repo's .gitconfig.
        # Clear that narrow, known-safe stub so the symlink can take its
        # place - anything else found there is left alone to avoid losing
        # real local customization.
        $lfsStubLines = @(
            '[filter "lfs"]',
            'smudge = git-lfs smudge -- %f',
            'process = git-lfs filter-process',
            'required = true',
            'clean = git-lfs clean -- %f'
        ) | Sort-Object

        $existingGitconfig = Get-Item $gitconfigLink -Force -ErrorAction SilentlyContinue
        if ($existingGitconfig -and -not $existingGitconfig.LinkType) {
            $existingLines = Get-Content $gitconfigLink -ErrorAction SilentlyContinue |
                ForEach-Object { $_.Trim() } | Where-Object { $_ } | Sort-Object
            if ($existingLines -and (-not (Compare-Object $existingLines $lfsStubLines))) {
                Remove-Item $gitconfigLink -Force
            }
        }

        New-Symlink -Target $gitconfigSrc -Link $gitconfigLink
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
