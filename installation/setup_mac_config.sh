#!/usr/bin/env bash

# Function to setup mac config
setup_mac_config() {
  echo ${COLOR_GREEN}"Configuring MAC defaults..${COLOR_REST}"
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
}

setup_mac_config
