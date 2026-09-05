#!/bin/bash
set -euo pipefail

echo "=========================================================================="
echo "Configuring macOS Quality-of-Life System Defaults..."
echo "=========================================================================="

# ------------------------------------------------------------------------------
# 1. Dark Mode
# ------------------------------------------------------------------------------
echo "--> Enabling Dark Mode..."
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# ------------------------------------------------------------------------------
# 2. Dock Preferences (Make Dock Disappear)
# ------------------------------------------------------------------------------
echo "--> Hiding Dock completely (instant auto-hide)..."
# Enable Dock auto-hide
defaults write com.apple.dock autohide -bool true
# Remove response delay when mouse hovers over Dock edge
defaults write com.apple.dock autohide-delay -float 0
# Accelerate hide/show animation duration
defaults write com.apple.dock autohide-time-modifier -float 0.1
# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# ------------------------------------------------------------------------------
# 3. Disable Ctrl+Number (Ctrl+1..Ctrl+9) Shortcuts for AeroSpace
# ------------------------------------------------------------------------------
echo "--> Disabling macOS Mission Control Ctrl+Number space-switching shortcuts..."
# Hotkey IDs 118 to 127 in com.apple.symbolichotkeys correspond to "Switch to Desktop 1..10"
PLIST="$HOME/Library/Preferences/com.apple.symbolichotkeys.plist"
if [ -f "$PLIST" ]; then
    for key in {118..127}; do
        /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:$key:enabled false" "$PLIST" 2>/dev/null || \
        /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:$key:enabled bool false" "$PLIST" 2>/dev/null || true
    done
    # Activate hotkey changes
    defaults read com.apple.symbolichotkeys >/dev/null 2>&1 || true
fi

# ------------------------------------------------------------------------------
# 4. Window & Full Screen Preferences
# ------------------------------------------------------------------------------
echo "--> Preferring tabbed windows globally..."
defaults write NSGlobalDomain AppleWindowTabbingMode -string "always"

# Note regarding Full Screen & AeroSpace:
# macOS native full-screen launches app into a separate Space. When using AeroSpace
# tiling window manager, AeroSpace automatically manages window bounds and tiling on launch.

# ------------------------------------------------------------------------------
# 5. Finder & File Management QoL Defaults
# ------------------------------------------------------------------------------
echo "--> Enabling Finder QoL defaults (hidden files, extensions, folder sorting)..."
# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# Disable creation of .DS_Store files on network and USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# ------------------------------------------------------------------------------
# 6. Mouse Controls (Windows-Style Scroll & Acceleration)
# ------------------------------------------------------------------------------
echo "--> Configuring Windows-style Mouse controls..."
# Disable "Natural" scrolling (scroll wheel up moves page up, Windows-style)
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Disable macOS mouse acceleration curve (flat/linear response on modern macOS versions)
defaults write NSGlobalDomain com.apple.mouse.scaling -1
defaults write NSGlobalDomain com.apple.mouse.acceleration -1

# Keep Press-and-Hold ENABLED (default) so holding keys opens the accent picker popup menu (e.g. á, é, ç)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true

# ------------------------------------------------------------------------------
# 7. iTerm2 Option Keys (Esc+ / Meta key for SSH) & Appearance
# ------------------------------------------------------------------------------
echo "--> Configuring iTerm2 Option keys (Esc+) & borderless window style..."
# Set Left and Right Option keys to act as Esc+ (Meta/Alt key for Linux & SSH)
defaults write com.googlecode.iterm2 "LeftOption" -int 2
defaults write com.googlecode.iterm2 "RightOption" -int 2

# Remove iTerm2 window borders for clean terminal layout
defaults write com.googlecode.iterm2 "UseBorder" -bool false

# ------------------------------------------------------------------------------
# 8. Restart Affected macOS Services
# ------------------------------------------------------------------------------
echo "--> Restarting Finder and Dock to apply changes..."
killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true

echo ""
echo "=========================================================================="
echo "macOS QoL defaults applied successfully!"
echo "Note: Log out and log back in (or restart iTerm2) for mouse & shortcut changes to take full effect."
echo "=========================================================================="
