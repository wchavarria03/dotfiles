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
# Reading: - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/

COLOR_REST=$(tput sgr0)
COLOR_GREEN=$(tput setaf 2)

echo "${COLOR_GREEN}*------------------------  Starting MAC Setup...                            --------------------*${COLOR_REST}"

echo "${COLOR_GREEN}*------------------------    Creating folders structure...                  ------------------------*${COLOR_REST}"
[[ ! -d ~/code ]] && mkdir ~/code
[[ ! -d ~/Documents/screenshots ]] && mkdir ~/Documents/screenshots && echo '~/Documents/screenshots folder created!!'
[[ ! -d ~/.config ]] && mkdir ~/.config && echo '~/.config folder created!!'
[[ ! -d ~/.config/nvim ]] && mkdir ~/.config/nvim && echo '~/.config/nvim folder created!!'
[[ ! -d ~/.zsh_autoload_functions ]] && mkdir ~/.zsh_autoload_functions && echo '~/.zsh_autoload_functions folder created!!'

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "${COLOR_GREEN}*------------------------    Installing homebrew...                         ------------------------*${COLOR_REST}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "${COLOR_GREEN}*------------------------    Homebrew already installed...                  ------------------------*${COLOR_REST}"
fi

echo "${COLOR_GREEN}*------------------------    Updating homebrew...                           ------------------------*${COLOR_REST}"
brew update

echo "${COLOR_GREEN}*------------------------    Upgrading homebrew...                          ------------------------*${COLOR_REST}"
brew upgrade

if brew info bash &>/dev/null; then
  echo "${COLOR_GREEN}*------------------------    Brew Bash package already installed            ------------------------*${COLOR_REST}"
else
  echo "${COLOR_GREEN}*------------------------    Installing Brew Bash package...                ------------------------*${COLOR_REST}"
  brew install bash
fi

PACKAGES=(
#  ack
  bash-completion
  fzf
  git
  gh
  glow # markdown previewer
  hub
  npm
#  python
  python3
# the_silver_searcher
  romkatv/powerlevel10k/powerlevel10k
  ripgrep
  tree
  nvim
  nvm
  zsh
#  wget

# APPS
  brave-browser
  gimp
  google-chrome
  gnupg
  iterm2
  notion
  postman
  sequel-ace
  slack
  spectacle
  1password
  1password/tap/1password-cli
  alfred
  stats
)

echo "${COLOR_GREEN}*------------------------                                                   ------------------------*${COLOR_REST}"
echo "${COLOR_GREEN}*------------------------    Brew packages...                               ------------------------*${COLOR_REST}"

for i in "${PACKAGES[@]}"
do
  if  brew info $i &>/dev/null; then
    echo "${COLOR_GREEN}*------------------------      ${i} package already installed          ------------------------*${COLOR_REST}"
  else
    echo "${COLOR_GREEN}*------------------------     Installing ${i} package..          ------------------------*${COLOR_REST}"
    brew install $i
  fi
done

echo "${COLOR_GREEN}*------------------------                                                   ------------------------*${COLOR_REST}"


echo "${COLOR_GREEN}*------------------------   Installing Brew cask docker...------------------------*${COLOR_REST}"
brew install --cask docker

echo "${COLOR_GREEN}*------------------------    Cleaning up Brew...------------------------*${COLOR_REST}"
brew cleanup

echo "${COLOR_GREEN}*------------------------     Installing brew cask fonts...------------------------*${COLOR_REST}"
brew tap homebrew/cask-fonts

# TODO CHECK WHY ICONS ON TERMINAL ARE BROKEN WITH FIRA
FONTS=(
    font-meslo-for-powerline
)
brew install ${FONTS[@]}

echo "${COLOR_GREEN}*------------------------     Repos                                 --------------------*${COLOR_REST}"

if [ ! -d ~/code/dotfiles/ ]
then
    echo "${COLOR_GREEN}*------------------------       Cloning dotfiles repo...--------------------*${COLOR_REST}"
    cd ~/code
    git clone https://github.com/wchavarria03/dotfiles
else
    echo "${COLOR_GREEN}*------------------------       Updating dotfiles repo...--------------------*${COLOR_REST}"
    cd ~/code/dotfiles
    git pull
fi

# TODO CHECK IF STILL USED
if [ ! -d ~/code/common/ ]
then
    echo "${COLOR_GREEN}*------------------------       Cloning common repo...--------------------*${COLOR_REST}"
    cd ~/code
    git clone https://github.com/wchavarria03/common
else
    echo "${COLOR_GREEN}*------------------------       Updating common repo...--------------------*${COLOR_REST}"
    cd ~/code/common
    git pull
    cd ~/code/dotfiles
fi

if [ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]
then
    echo "${COLOR_GREEN}*------------------------       Cloning Powerlevel10k repo...--------------------*${COLOR_REST}"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
    echo "${COLOR_GREEN}*------------------------       Updating Powerlevel10k repo...--------------------*${COLOR_REST}"
    cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git pull
    cd ~/code/dotfiles
fi

echo "${COLOR_GREEN}*------------------------     ZSH Auto load op_env symlinks--------------------*${COLOR_REST}"
ln -s ~/code/dotfiles/.zsh_autoload_functions/env-op ~/.zsh_autoload_functions/env-op

# TOD CONFIRM IF STILL USED
echo "${COLOR_GREEN}*------------------------     Common repo symlink--------------------*${COLOR_REST}"
ln -s ~/code/common/common.zsh-theme ~/.oh-my-zsh/custom/themes/common.zsh-theme

echo "${COLOR_GREEN}*------------------------     Configuring powerline repo--------------------*${COLOR_REST}"
ln -s ~/code/dotfiles/.p10k.zsh ~/.p10k.zsh

echo "${COLOR_GREEN}*------------------------     ZSHR symlink--------------------*${COLOR_REST}"
ln -s ~/code/dotfiles/.zshrc ~/.zshrc

echo "${COLOR_GREEN}*------------------------     Gitconfig symlink--------------------*${COLOR_REST}"
ln -s ~/code/dotfiles/.gitconfig ~/.gitconfig

echo ${COLOR_GREEN}"*------------------------     Git Ignore Global symlink--------------------*${COLOR_REST}"
ln -s ~/code/dotfiles/.gitignore_global ~/.gitignore_global

echo ${COLOR_GREEN}"*------------------------     Configuring Lua..--------------------*${COLOR_REST}"
echo ${COLOR_GREEN}"*------------------------       Init.lua symlink--------------------*${COLOR_REST}"
ln -s ~/code/dotfiles/lua-files/init.lua ~/.config/nvim/init.lua

echo "${COLOR_GREEN}*------------------------       Lua folder symlink--------------------*${COLOR_REST}"
ln -s ~/code/dotfiles/lua-files/lua ~/.config/nvim/lua

# ------------------------------ OSX CONFIG
echo "${COLOR_GREEN}*------------------------     Configuring OSX...--------------------*${COLOR_REST}"

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2

# Repeat keys
defaults write -g ApplePressAndHoldEnabled -bool true

# Screenshots folder
defaults write com.apple.screencapture location ~/Documents/screenshots/

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
defaults write -g com.apple.swipescrolldirection -bool false

# Change Dock to left position
 defaults write com.apple.dock orientation left;

# Speed up animations
 defaults write com.apple.dock expose-animation-duration -float 0.12

# Translucent hidden apps
 defaults write com.apple.Dock showhidden -bool YES

# Remove full name when copying emails addresses
 defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Enable quick view selection
 defaults write com.apple.finder QLEnableTextSelection -bool TRUE;

# Enabling Right click with mouse
defaults write com.apple.AppleMultitouchMouse MouseButtonMode TwoButton

#Enabling right click with trackpad
# defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseOneFingerDoubleTapGesture 1
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick 0
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool false

# Increase mouse speed
defaults write com.apple.trackpad scaling -int 3

killall Finder
killall Dock
killall SystemUIServer

echo "${COLOR_GREEN}*-----------------------  Bootstrapping complete!!!--------------------*${COLOR_REST}"
