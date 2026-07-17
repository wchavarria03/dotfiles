# install.ps1
# Bootstrap script for setting up a new Windows machine.
# Mirrors the structure of install.sh — safe to run multiple times.
#
# Requirements:
#   - Run as Administrator (needed for creating symlinks)
#   - PowerShell 5.1+ or PowerShell 7+
#   - winget available (comes with Windows 10 1709+ / Windows 11)
#
# Usage (from an elevated PowerShell prompt):
#   Set-ExecutionPolicy Bypass -Scope Process -Force
#   .\install.ps1

#Requires -RunAsAdministrator

$ErrorActionPreference = "Stop"

# ── Colors via Write-Host are built-in; just use -ForegroundColor ─────────────

function Write-Stage {
    param([string]$Message)
    Write-Host ""
    Write-Host "******** $Message ********" -ForegroundColor Green
}

function main {
    Write-Host "******************************" -ForegroundColor Green
    Write-Host "**** Installation script  ****" -ForegroundColor Green
    Write-Host "******************************" -ForegroundColor Green

    # ── Stage 1 - Load helpers ────────────────────────────────────────────────
    Write-Stage "Stage 1 - Load helpers"
    . "$PSScriptRoot\helpers_windows.ps1"
    Ensure-OsType

    # ── Stage 2 - Git + Dotfiles ──────────────────────────────────────────────
    Write-Stage "Stage 2 - Git and Dotfiles"
    . "$PSScriptRoot\setup_git_windows.ps1"
    Setup-Git

    # ── Stage 3 - WezTerm ─────────────────────────────────────────────────────
    Write-Stage "Stage 3 - WezTerm"
    . "$PSScriptRoot\setup_wezterm_windows.ps1"
    Setup-Wezterm

    # ── Stage 4 - Starship ────────────────────────────────────────────────────
    Write-Stage "Stage 4 - Starship"
    . "$PSScriptRoot\setup_starship_windows.ps1"
    Setup-Starship

    # ── Stage 5 - GlazeWM ─────────────────────────────────────────────────────
    Write-Stage "Stage 5 - GlazeWM"
    . "$PSScriptRoot\setup_glazewm_windows.ps1"
    Setup-GlazeWM

    # ── Stage 6 - zoxide ──────────────────────────────────────────────────────
    Write-Stage "Stage 6 - zoxide"
    . "$PSScriptRoot\setup_zoxide_windows.ps1"
    Setup-Zoxide

    # ── Stage 7 - Extras (ripgrep, fzf, imagemagick, glow, PowerToys, Brave) ──
    Write-Stage "Stage 7 - Extras"
    . "$PSScriptRoot\setup_extras_windows.ps1"
    Setup-Extras

    # ── Done ──────────────────────────────────────────────────────────────────
    Write-Host ""
    Write-Host "******** Windows setup complete! ********" -ForegroundColor Green
    Write-Host "Note: Restart your terminal for all PATH changes to take effect."
}

main
