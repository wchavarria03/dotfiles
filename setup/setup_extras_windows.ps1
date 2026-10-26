# setup_extras_windows.ps1
# Installs supporting tools with no dotfiles-managed config of their own:
# ripgrep/fzf (also used by Doom Emacs), imagemagick/glow, Emacs for the
# org-roam notes (Doom is set up separately), PowerToys for
# keyboard-driven app launching (PowerToys Run) and key remapping, and Brave
# (referenced by the GlazeWM window rule for workspace 'b').

. "$PSScriptRoot\helpers_windows.ps1"

function Setup-Extras {
    Winget-Install @(
        "BurntSushi.ripgrep.MSVC",
        "junegunn.fzf",
        "ImageMagick.ImageMagick",
        "charmbracelet.glow",
        "GNU.Emacs",
        "Microsoft.PowerToys",
        "Brave.Brave"
    )
}
