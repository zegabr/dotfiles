#!/bin/bash
set -euo pipefail

echo "=========================================================================="
echo "Configuring macOS Quality-of-Life System Defaults..."
echo "=========================================================================="

# List to collect settings restricted by macOS SIP / TCC permissions
MANUAL_STEPS=()

set_or_warn() {
    local setting_name="$1"
    local manual_location="$2"
    shift 2
    if ! "$@" 2>/dev/null; then
        MANUAL_STEPS+=("• $setting_name: System Settings -> $manual_location")
    fi
}

# ------------------------------------------------------------------------------
# 1. Dark Mode & UI Appearance
# ------------------------------------------------------------------------------
echo "--> Configuring Dark Mode, Icon/Widget styling, and Menu Bar background..."
# System Dark Mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Icon and widget style: Dark
defaults write NSGlobalDomain AppleIconAppearanceTheme -string "RegularDark"

# Show menu bar background (blurred appearance)
defaults write NSGlobalDomain SLSMenuBarUseBlurredAppearance -bool true

# Reduce Motion (Accessibility)
defaults write com.apple.universalaccess reduceMotion -bool true
defaults write com.apple.Accessibility ReduceMotionEnabled -bool true

# ------------------------------------------------------------------------------
# 2. Dock Preferences
# ------------------------------------------------------------------------------
echo "--> Configuring Dock (size 58, magnification 48, scale effect, no auto-rearrange)..."
# Auto-hide Dock (native timing, no delay/animation hacks)
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false

# Dock size and magnification
defaults write com.apple.dock tilesize -int 58
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 48

# Minimized window animation = scale effect
defaults write com.apple.dock mineffect -string "scale"

# Automatically rearrange spaces based on most recent use = false
defaults write com.apple.dock mru-spaces -bool false

# ------------------------------------------------------------------------------
# 3. Disable Ctrl+Number (Ctrl+1..Ctrl+9) Shortcuts for AeroSpace
# ------------------------------------------------------------------------------
echo "--> Disabling macOS Mission Control Ctrl+Number space-switching shortcuts..."
for key in {118..127}; do
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$key" '<dict><key>enabled</key><false/></dict>'
done
defaults read com.apple.symbolichotkeys >/dev/null 2>&1 || true

# ------------------------------------------------------------------------------
# 4. Window & Keyboard Navigation Preferences
# ------------------------------------------------------------------------------
echo "--> Setting window & keyboard navigation preferences..."
defaults write NSGlobalDomain AppleWindowTabbingMode -string "always"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2
# Enable Cmd+` to cycle through windows of the current application
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 27 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>50</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>'

# ------------------------------------------------------------------------------
# 5. Finder & File Management QoL Defaults
# ------------------------------------------------------------------------------
echo "--> Enabling Finder QoL defaults (hidden files, extensions, folder sorting)..."
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# ------------------------------------------------------------------------------
# 6. Keyboard & Text Preferences
# ------------------------------------------------------------------------------
echo "--> Configuring Keyboard repeat rates and ABC layout..."
# Fast repeat rate (2) and initial delay (15 = ~225ms)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true

# Ensure standard ABC layout is default
defaults write com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID "com.apple.keylayout.ABC"

# Text substitutions (try setting programmatically; notify if restricted by macOS)
set_or_warn "Disable Auto-Correct" \
    "Keyboard -> Input Sources (Edit) -> Turn OFF 'Correct spelling automatically'" \
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

set_or_warn "Disable Auto-Capitalization" \
    "Keyboard -> Input Sources (Edit) -> Turn OFF 'Capitalize words automatically'" \
    defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

set_or_warn "Disable Double-Space Period" \
    "Keyboard -> Input Sources (Edit) -> Turn OFF 'Add period with double-space'" \
    defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

set_or_warn "Disable Smart Quotes & Dashes" \
    "Keyboard -> Input Sources (Edit) -> Turn OFF 'Use smart quotes and dashes'" \
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# ------------------------------------------------------------------------------
# 7. Trackpad & Mouse Preferences
# ------------------------------------------------------------------------------
echo "--> Configuring Trackpad (Light click, speed 1.0, tap-to-click) & Mouse..."
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true
defaults write NSGlobalDomain com.apple.mouse.scaling -1
defaults write NSGlobalDomain com.apple.mouse.acceleration -1

defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true 2>/dev/null || true

defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true 2>/dev/null || true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0 2>/dev/null || true

defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool false

# ------------------------------------------------------------------------------
# 8. Menu Bar & Control Center Preferences
# ------------------------------------------------------------------------------
echo "--> Configuring Menu Bar and Control Center items..."
# Hide Bluetooth icon from Menu Bar (remains accessible via Control Center)
defaults -currentHost write com.apple.controlcenter Bluetooth -int 2

# Show Battery percentage & energy mode
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true
defaults -currentHost write com.apple.controlcenter BatteryShowEnergyMode -bool true

# Focus Modes & Spotlight in menu bar / control center
defaults -currentHost write com.apple.controlcenter FocusModes -int 8
defaults -currentHost write com.apple.controlcenter Spotlight -int 8

# Clock format: Show AM/PM and Day of Week, hide Date
defaults write com.apple.menuextra.clock ShowAMPM -bool true
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowDate -int 0

# ------------------------------------------------------------------------------
# 9. Displays, External TV Mirroring & Night Shift
# ------------------------------------------------------------------------------
echo "--> Configuring Displays, resolution list, and Night Shift (Sunset to Sunrise)..."
set_or_warn "Show Display Resolutions as List" \
    "Displays -> Advanced... -> Turn ON 'Show resolutions as list'" \
    defaults write com.apple.preference.displays ShowAllResolutions -bool true

defaults write com.apple.airplay showInMenuBarIfPresent -bool true

# Schedule Night Shift (Nightlight) from Sunset to Sunrise via CoreBrightness
python3 -c "
import ctypes
libobjc = ctypes.cdll.LoadLibrary('/usr/lib/libobjc.A.dylib')
cb = ctypes.cdll.LoadLibrary('/System/Library/PrivateFrameworks/CoreBrightness.framework/CoreBrightness')

libobjc.objc_getClass.restype = ctypes.c_void_p
libobjc.sel_registerName.restype = ctypes.c_void_p
msgSend = libobjc.objc_msgSend
msgSend.restype = ctypes.c_void_p

cls = libobjc.objc_getClass(b'CBBlueLightClient')
obj = ctypes.cast(msgSend, ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p))(cls, libobjc.sel_registerName(b'alloc'))
obj = ctypes.cast(msgSend, ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p))(obj, libobjc.sel_registerName(b'init'))

# Mode 1 = Sunset to Sunrise
setMode_fn = ctypes.cast(msgSend, ctypes.CFUNCTYPE(ctypes.c_bool, ctypes.c_void_p, ctypes.c_void_p, ctypes.c_int))
res_mode = setMode_fn(obj, libobjc.sel_registerName(b'setMode:'), 1)

setEnabled_fn = ctypes.cast(msgSend, ctypes.CFUNCTYPE(ctypes.c_bool, ctypes.c_void_p, ctypes.c_void_p, ctypes.c_bool))
res_enabled = setEnabled_fn(obj, libobjc.sel_registerName(b'setEnabled:'), True)
if not res_mode or not res_enabled:
    raise RuntimeError('Failed to configure Night Shift schedule')
"

# ------------------------------------------------------------------------------
# 10. Spotlight & Native Clipboard History (macOS 27 Cmd+4)
# ------------------------------------------------------------------------------
echo "--> Configuring Spotlight & native Pasteboard history..."
defaults write com.apple.Spotlight PasteboardHistoryEnabled -bool true
defaults write com.apple.Spotlight PasteboardHistoryTimeout -int 28800
defaults write com.apple.Spotlight PasteboardHistoryVersion -int 3
defaults write com.apple.Spotlight SPPasteboardFTEEngaged -int 1

# ------------------------------------------------------------------------------
# 11. Restart Affected macOS Services
# ------------------------------------------------------------------------------
echo "--> Restarting Finder, Dock, and Control Center to apply changes..."
killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true
killall ControlCenter 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo ""
echo "=========================================================================="
echo "macOS QoL defaults applied successfully!"
echo "Note: Log out and log back in for all keyboard, trackpad & display changes to take full effect."
echo "=========================================================================="

# ------------------------------------------------------------------------------
# 12. Manual Configuration Summary (for permission/SIP protected settings)
# ------------------------------------------------------------------------------
if [ ${#MANUAL_STEPS[@]} -gt 0 ]; then
    echo ""
    echo "=========================================================================="
    echo "ACTION REQUIRED: macOS privacy/SIP restrictions prevented modifying the"
    echo "following settings programmatically. Please toggle them manually:"
    echo "=========================================================================="
    for step in "${MANUAL_STEPS[@]}"; do
        echo "  $step"
    done
    echo "=========================================================================="
    echo ""
fi
