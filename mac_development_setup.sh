#!/usr/bin/env bash
#
# Bootstrap script for setting up a new OSX machine
#
# This should be idempotent so it can be run multiple times.
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/

echo "Starting MAC Setup..."

echo "Creating folders structure..."
[[ ! -d ~/code ]] && mkdir ~/code
[[ ! -d ~/Documents/screenshots ]] && mkdir ~/Documents/screenshots
[[ ! -d ~/.config ]] && mkdir ~/.config
[[ ! -d ~/.config/nvim ]] && mkdir ~/.config/nvim"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes

echo "Updating homebrew..."
brew update

echo "Upgrading homebrew..."
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated)
#brew tap homebrew/dupes
#brew install coreutils
#brew install gnu-sed --with-default-names
#brew install gnu-tar --with-default-names
#brew install gnu-indent --with-default-names
#brew install gnu-which --with-default-names
#brew install gnu-grep --with-default-names

## Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
#brew install findutils

# Install Bash 4
brew install bash

PACKAGES=(
#    ack
    bash-completition
    docker-completition
    fzf
    gimp
    git
    hub
    npm
    python
    python3
    pypy
#    the_silver_searcher
    ripgrep
    tree
    nvim
    nvm
    zsh
    zsh-completition
#    wget
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew install caskroom/cask/brew-cask

CASKS=(
    brave-browser
    docker
    firefox
    google-chrome
    gpgtools
    iterm2
    notion
    postman
    sequel-pro
    slack
    spectacle
    1password
)

echo "Installing cask apps..."
brew cask install ${CASKS[@]}

echo "Installing fonts..."
brew tap homebrew/cask-fonts

FONTS=(
    font-fira-code
)
brew install ${FONTS[@]}

echo "Installing global npm packages..."
npm install marked -g

echo "Configuring OSX..."

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Repeat keys
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false.

# Screenshots folder
defaults write com.apple.screencapture location /Documents/screenshots/

# Show hidden files on finder
defaults write com.apple.Finder AppleShowAllFiles -bool YES

# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Change secondary click on right corner
defaults -currentHost write -g com.apple.trackpad.enableSecondaryClick -bool YES

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Change Dock to left position
defaults write com.apple.dock orientation left;

# Spped up animations
defaults write com.apple.dock expose-animation-duration -float 0.12

# Translucent hidden apps
defaults write com.apple.Dock showhidden -bool YES

# Remove full name when copying emails addresses
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Enable quick view selection
defaults write com.apple.finder QLEnableTextSelection -bool TRUE;

killall Finder
killall Dock
killall SystemUIServer

echo "Cloning config repos.."
echo "- Cloning common repo..."
git clone https://github.com/wchavarria03/common "~/code/common/"

echo "- Cloning powerlevel10k repo..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Common repo symlink"
ln -s ~/code/common/common.zsh-theme ~/.oh-my-zsh/custom/themes/common.zsh-theme

echo "- Configuring powerline repo"
ln -s ~/code/dotfiles/.p10k.zsh ~/.p10k.zsh

echo "ZSHR symlink"
ln -s ~/code/dotfiles/.zshrc ~/.zshrc

echo "Gitconfig symlink"
ln -s ~/code/dotfiles/.gitconfig ~/.gitconfig

echo "Gitconfig symlink"
ln -s ~/code/dotfiles/.gitignore_global ~/.gitignore_global

echo "Configuring Lua.."
echo " -- Init.lua symlink"
ln -s ~/code/dotfiles/lua/init.lua ~/.config/nvim/init.lua

echo " -- Doc folder symlink"
ln -s ~/code/dotfiles/lua/doc/ ~/.config/nvim/doc/

echo " -- Lua folder folder symlink"
ln -s ~/code/dotfiles/lua/lua ~/.config/nvim/lua

echo "Bootstrapping complete!!!"
