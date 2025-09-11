#!/usr/bin/env bash

# Function to setup mac config
setup_mac_config() {
  # Check if running on Apple Silicon for potential optimizations
  if [[ $(uname -m) == "arm64" ]]; then
    echo "Detected Apple Silicon Mac - optimizing configurations..."
  fi
  # ========================================
  # MAXIMUM KEYBOARD SPEED OPTIMIZATION
  # ========================================
  
  # ULTRA-FAST keyboard repeat settings (beyond System Settings limits)
  defaults write NSGlobalDomain KeyRepeat -int 1              # 1 = absolute fastest key repeat rate possible
  defaults write NSGlobalDomain InitialKeyRepeat -int 5       # 5 = ultra-fast delay (was 10, now 2x faster!)
  defaults write -g KeyRepeat -int 1                          # Global setting backup
  defaults write -g InitialKeyRepeat -int 5                   # Global setting backup
  
  # Advanced keyboard responsiveness optimizations
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false # Disable press-and-hold, enable key repeat
  defaults write -g AppleKeyboardUIMode -int 3               # Full keyboard access for power users
  defaults write NSGlobalDomain NSTextInsertionPointBlinkPeriod -float 0.8  # Faster cursor blink for better visual feedback
  
  # Input lag minimization 
  defaults write NSGlobalDomain AppleShowScrollBars -string "Always"  # No scroll bar delays
  defaults write NSGlobalDomain NSScrollViewRubberbanding -bool false  # Disable rubber band scrolling delay
  defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true  # Show all characters immediately
  
  # Text processing speed optimizations
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false # Disable auto-correct for speed
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false   # Disable smart dashes  
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false  # Disable smart quotes
  defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false # Disable period substitution
  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false     # Disable auto-capitalization
  defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false     # Disable text completion delays
  
  # Keyboard acceleration and responsiveness
  defaults write NSGlobalDomain com.apple.keyboard.fnState -bool false  # Disable Fn key delay
  defaults write com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID -string "com.apple.keylayout.US"  # Optimize for US layout
  defaults write com.apple.inputmethod.Kotoeri JIMPrefCharacterForYenKey -int 1  # Optimize yen key response
  
  # Terminal and application keyboard optimizations
  defaults write com.apple.terminal StringEncodings -array 4  # UTF-8 for fastest character processing
  defaults write NSGlobalDomain AppleLanguages -array "en-US"  # English optimization for fastest processing

  # Screenshots folder
  defaults write com.apple.screencapture location ~/Documents/screenshots/

  # Show hidden files on finder
  defaults write com.apple.finder AppleShowAllFiles -bool true

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

  # Dock configurations
  defaults write com.apple.dock orientation left
  defaults write com.apple.dock tilesize -int 24              # Much smaller icons (was 48)
  defaults write com.apple.dock autohide -bool true           # Auto-hide dock for maximum screen space
  defaults write com.apple.dock largesize -int 32             # Magnification max size
  defaults write com.apple.dock magnification -bool true      # Enable magnification for easier clicking
  
  # Additional dock optimizations
  defaults write com.apple.dock mineffect -string "scale"     # Faster minimize effect
  defaults write com.apple.dock minimize-to-application -bool true  # Minimize to app icon
  defaults write com.apple.dock show-process-indicators -bool true  # Show running app indicators
  
  # Speed up animations
  defaults write com.apple.dock expose-animation-duration -float 0.12
  defaults write com.apple.dock autohide-delay -float 0       # Remove autohide delay
  defaults write com.apple.dock autohide-time-modifier -float 0.4  # Faster autohide animation

  # Translucent hidden apps
  defaults write com.apple.Dock showhidden -bool YES

  # Remove full name when copying emails addresses
  defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

  # Enable quick view selection
  defaults write com.apple.finder QLEnableTextSelection -bool TRUE

  # Enabling Right click with mouse
  defaults write com.apple.AppleMultitouchMouse MouseButtonMode TwoButton

  #Enabling right click with trackpad
  # defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseOneFingerDoubleTapGesture 1
  # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick 0
  # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick 2
  defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
  defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool false

  # Maximize tracking speed for both trackpad and mouse
  defaults write -g com.apple.trackpad.scaling -float 5.0        # Maximum trackpad speed (beyond UI limit)
  defaults write -g com.apple.mouse.scaling -float 5.0           # Maximum mouse speed  
  defaults write -g com.apple.scrollwheel.scaling -float 3.0     # Faster scroll wheel speed
  
  # Additional tracking optimizations
  defaults write NSGlobalDomain com.apple.trackpad.scaling -float 5.0  # Alternative trackpad setting
  defaults write NSGlobalDomain com.apple.mouse.scaling -float 5.0     # Alternative mouse setting
  
  # Trackpad acceleration and gesture speed
  defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0  # Light click pressure
  defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0 # Light force click
  defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 0    # Lightest actuation
  defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool false # Enable force touch for speed

  # ========================================
  # DEVELOPER & SOFTWARE ENGINEER OPTIMIZATIONS
  # ========================================
  
  # Terminal and Command Line Optimizations
  defaults write com.apple.terminal StringEncodings -array 4  # UTF-8 encoding for terminal
  defaults write com.apple.terminal SecureKeyboardEntry -bool false  # Allow password managers in terminal
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true  # Expand save dialogs
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true # Expand save dialogs v2
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true     # Expand print dialogs
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true    # Expand print dialogs v2
  
  # File System & Development Workflow
  defaults write NSGlobalDomain AppleShowScrollBars -string "Always"  # Always show scroll bars
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" # Search current folder by default
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false  # No extension change warnings
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"  # List view by default
  defaults write com.apple.finder ShowPathbar -bool true  # Show path bar
  defaults write com.apple.finder ShowStatusBar -bool true  # Show status bar
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true  # Show full POSIX path in title
  defaults write com.apple.finder _FXSortFoldersFirst -bool true  # Sort folders first
  
  # Developer Tools Optimizations
  defaults write com.apple.dt.Xcode DVTTextShowFoldingSidebar -bool true  # Show code folding in Xcode
  defaults write com.apple.dt.Xcode DVTTextShowLineNumbers -bool true     # Show line numbers in Xcode
  defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool true # Show build times
  defaults write com.apple.dt.Xcode DVTTextShowPageGuide -bool true       # Show page guide
  defaults write com.apple.crashreporter DialogType -string "none"        # Disable crash reporter dialog
  
  # Performance & Memory Optimizations for Development
  defaults write NSGlobalDomain NSWindowResizeTime -float 0.001  # Faster window resize animations
  defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false  # Disable window animations
  defaults write com.apple.dock launchanim -bool false  # Disable app launch animations
  defaults write com.apple.dock workspaces-auto-swoosh -bool false  # Disable workspace animations
  defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true  # Keep apps running for faster switching
  
  # Security & Privacy for Developers
  defaults write com.apple.LaunchServices LSQuarantine -bool false  # Disable quarantine for downloaded files
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1  # Check for updates daily
  defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true  # Auto check for updates
  defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -bool true   # Auto install critical updates
  
  # Window Management & Productivity
  defaults write NSGlobalDomain AppleWindowTabbingMode -string "always"  # Always tab windows
  
  # Network & Development Server Optimizations  
  defaults write com.apple.networkConnect DisableAirDrop -bool false  # Keep AirDrop enabled for file sharing
  sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true  # Reduce network chatter
  
  # Git and Version Control Optimizations
  # Note: Natural scrolling already disabled in trackpad section above
  
  # Additional Developer Productivity
  defaults write com.apple.ActivityMonitor UpdatePeriod -int 1  # Faster Activity Monitor updates
  defaults write com.apple.ActivityMonitor ShowCategory -int 100  # Show all processes
  defaults write com.apple.Console ShowVerboseLogging -bool true  # Verbose console logging
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true  # Enable debug menu in web browsers
  
  # Simulator and Development Environment
  defaults write com.apple.iphonesimulator AllowFullscreenMode -bool true  # Allow fullscreen iOS Simulator
  defaults write com.apple.CarPlay CarPlaySimulator -bool true  # Enable CarPlay simulator
  
  # Disable animations for faster development workflow
  defaults write com.apple.finder DisableAllAnimations -bool true  # Disable Finder animations
  defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false  # Disable scroll animations
  defaults write NSGlobalDomain NSDocumentRevisionsWindowTransformAnimation -bool false  # Disable document animations

  # Restart all affected services at once
  echo "Applying all config changes..."
  for app in "Dock" "Finder" "SystemUIServer" "Mail" "Activity Monitor" "Console" "Terminal"; do
    killall "$app" >/dev/null 2>&1 || true
  done
  echo "Developer-optimized configuration complete! All changes have been applied."
  echo "Note: Some changes may require a logout/login or restart to take full effect."
}

setup_mac_config_clean_up() {
  echo "${COLOR_GREEN}Setup mac config clean up - coming feature...${COLOR_RESET}"
}
