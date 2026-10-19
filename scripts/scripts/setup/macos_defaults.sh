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
# 1. Dark Mode, Liquid Glass, Menu Bar & Accessibility Appearance
# ------------------------------------------------------------------------------
echo "--> Configuring Dark Mode, Liquid Glass tint, Menu Bar, and Accessibility display..."
# System Dark Mode & Dark Icon/Widget style
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain AppleIconAppearanceTheme -string "RegularDark"

# Liquid Glass tint preferences
defaults write NSGlobalDomain NSGlassTintAmount -float 1.0

# Menu Bar appearance, default font size, and full-screen visibility
defaults write NSGlobalDomain SLSMenuBarUseBlurredAppearance -bool true
defaults delete NSGlobalDomain AppleMenuBarFontSize 2>/dev/null || true
defaults write NSGlobalDomain AppleMenuBarVisibleInFullscreen -bool false
defaults write NSGlobalDomain _HIHideMenuBar -bool false
defaults write com.apple.controlcenter AutoHideMenuBarOption -int 2
defaults write com.apple.controlcenter RemoteLiveActivitiesEnabled -bool true

# Sidebar icon size (Medium = 2), font smoothing & content size category
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
defaults write NSGlobalDomain AppleAntiAliasingThreshold -int 4
defaults write NSGlobalDomain UIPreferredContentSizeCategoryName -string "UICTContentSizeCategoryL"

# Accessibility: Reduce Motion & Reduce Transparency (Enhanced Background Contrast)
set_or_warn "Reduce Motion (UniversalAccess)" \
    "Accessibility -> Display -> Turn ON 'Reduce motion'" \
    defaults write com.apple.universalaccess reduceMotion -bool true
set_or_warn "Reduce Motion (Accessibility)" \
    "Accessibility -> Display -> Turn ON 'Reduce motion'" \
    defaults write com.apple.Accessibility ReduceMotionEnabled -int 1

set_or_warn "Reduce Transparency (UniversalAccess)" \
    "Accessibility -> Display -> Turn ON 'Reduce transparency'" \
    defaults write com.apple.universalaccess reduceTransparency -bool true
set_or_warn "Reduce Transparency / Enhanced Background Contrast" \
    "Accessibility -> Display -> Turn ON 'Reduce transparency'" \
    defaults write com.apple.Accessibility EnhancedBackgroundContrastEnabled -int 1

# Additional Accessibility Display & Navigation defaults
defaults write com.apple.universalaccess differentiateWithoutColor -bool false
defaults write com.apple.Accessibility DifferentiateWithoutColor -int 0
defaults write com.apple.universalaccess grayscale -bool false
defaults write com.apple.Accessibility GrayscaleDisplay -int 0
defaults write com.apple.Accessibility InvertColorsEnabled -int 0
defaults write com.apple.Accessibility DarkenSystemColors -int 0
defaults write com.apple.Accessibility ButtonShapesEnabled -int 0
defaults write com.apple.Accessibility PrefersHorizontalText -int 0
defaults write com.apple.Accessibility FullKeyboardAccessEnabled -int 0
defaults write com.apple.Accessibility FullKeyboardAccessFocusRingEnabled -int 1
defaults write com.apple.universalaccess showWindowTitlebarIcons -bool false
defaults write com.apple.universalaccess customFonts -bool true
defaults write com.apple.CoreGraphics DisplayUseForcedGray -bool false
defaults write com.apple.CoreGraphics DisplayUseInvertedPolarity -bool false

# ------------------------------------------------------------------------------
# 2. Wallpaper, Screen Saver & Lock Screen Appearance
# ------------------------------------------------------------------------------
echo "--> Configuring Wallpaper (Big Sur Dynamic), Screen Saver, and Lock Screen..."
set_or_warn "Desktop Wallpaper & Aerial Screen Saver (Big Sur Dynamic)" \
    "Wallpaper -> Dynamic Wallpapers -> Select 'Big Sur'" \
    python3 -c "
import os, plistlib, datetime

wp_index = os.path.expanduser('~/Library/Application Support/com.apple.wallpaper/Store/Index.plist')
if os.path.exists(wp_index):
    with open(wp_index, 'rb') as f:
        data = plistlib.load(f)
    now = datetime.datetime.now(datetime.timezone.utc).replace(tzinfo=None)
    desktop_cfg = plistlib.dumps({
        'type': 'systemDesktopPicture',
        'url': {'relative': 'file:///System/Library/Desktop%20Pictures/Big%20Sur.madesktop'}
    }, fmt=plistlib.FMT_BINARY)
    idle_cfg = plistlib.dumps({
        'assetID': '5EF41171-4862-4F93-800C-AD86CE5E6891'
    }, fmt=plistlib.FMT_BINARY)
    empty_opts = plistlib.dumps({'values': {}}, fmt=plistlib.FMT_BINARY)
    entry = {
        'Desktop': {
            'Content': {
                'Choices': [{
                    'Configuration': desktop_cfg,
                    'Files': [],
                    'Provider': 'com.apple.wallpaper.choice.dynamic'
                }],
                'EncodedOptionValues': empty_opts,
                'Shuffle': '\$null'
            },
            'LastSet': now,
            'LastUse': now
        },
        'Idle': {
            'Content': {
                'Choices': [{
                    'Configuration': idle_cfg,
                    'Files': [],
                    'Provider': 'com.apple.wallpaper.choice.aerials'
                }],
                'EncodedOptionValues': empty_opts,
                'Shuffle': '\$null'
            },
            'LastSet': now,
            'LastUse': now
        },
        'Type': 'individual'
    }
    data['AllSpacesAndDisplays'] = entry
    data['SystemDefault'] = entry
    with open(wp_index, 'wb') as f:
        plistlib.dump(data, f, fmt=plistlib.FMT_BINARY)
"

WALLPAPER_HEIC="$HOME/Library/Application Support/com.apple.mobileAssetDesktop/Big Sur.heic"
if [ ! -f "$WALLPAPER_HEIC" ]; then
    WALLPAPER_HEIC="/System/Library/Desktop Pictures/.thumbnails/Big Sur.heic"
fi
if [ -f "$WALLPAPER_HEIC" ]; then
    set_or_warn "Apply Desktop Picture via System Events" \
        "Wallpaper -> Select 'Big Sur'" \
        osascript -e "tell application \"System Events\" to tell every desktop to set picture to POSIX file \"$WALLPAPER_HEIC\"" >/dev/null
fi

# Screen Saver & Lock Screen clock style
defaults write com.apple.screensaver tokenRemovalAction -int 0
defaults write com.apple.loginwindow ClockFontIdentifier -string "soft"
defaults write com.apple.loginwindow ClockFontWeight -int 640
defaults write com.apple.loginwindow TALLogoutSavesState -bool false

# ------------------------------------------------------------------------------
# 3. Sound & Audio Feedback Preferences
# ------------------------------------------------------------------------------
echo "--> Configuring Sound & Alert preferences (Tink alert sound, UI audio)..."
defaults write NSGlobalDomain com.apple.sound.beep.sound -string "/System/Library/Sounds/Tink.aiff"
defaults write NSGlobalDomain com.apple.sound.beep.volume -float 0.7669242
defaults write NSGlobalDomain com.apple.sound.beep.flash -int 0
defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -int 1
defaults write com.apple.ComfortSounds comfortSoundsEnabled -bool false
defaults write com.apple.ComfortSounds timerEnabled -bool false

# ------------------------------------------------------------------------------
# 4. Dock, Stage Manager & Window Management Preferences
# ------------------------------------------------------------------------------
echo "--> Configuring Dock (instant auto-hide, size 58, magnification 48, scale effect) & Stage Manager..."
# Auto-hide Dock with instant response (0 delay, 0.1s animation)
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.1
defaults write com.apple.dock show-recents -bool false

# Dock size, magnification, and window behavior
defaults write com.apple.dock tilesize -int 58
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 48
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock minimize-to-application -bool false
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock show-process-indicators -bool true

# Spaces & Mission Control gestures in Dock
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock showAppExposeGestureEnabled -bool false
defaults write com.apple.dock showDesktopGestureEnabled -bool false

# Desktop, Stage Manager & Window Tiling (disable tiled window margins)
defaults write com.apple.WindowManager GloballyEnabled -bool false
defaults write com.apple.WindowManager AutoHide -bool true
defaults write com.apple.WindowManager HideDesktop -bool true
defaults write com.apple.WindowManager StageManagerHideWidgets -bool false
defaults write com.apple.WindowManager StandardHideWidgets -bool false
defaults write com.apple.WindowManager AppWindowGroupingBehavior -int 1
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false

# Global Window & Document handling
defaults write NSGlobalDomain AppleWindowTabbingMode -string "always"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false
defaults write NSGlobalDomain NSCloseAlwaysConfirmsChanges -bool true
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0.5
defaults write NSGlobalDomain shouldShowRSVPDataDetectors -bool false

# ------------------------------------------------------------------------------
# 5. Keyboard Shortcuts (AeroSpace, Window Cycling & Input Sources)
# ------------------------------------------------------------------------------
echo "--> Configuring macOS Symbolic HotKeys (AeroSpace Ctrl+Number, Cmd+\`, Input Sources)..."
# Disable Ctrl+1..Ctrl+0 (118..127) Mission Control space-switching shortcuts for AeroSpace
for key in {118..127}; do
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$key" '<dict><key>enabled</key><false/></dict>'
done

# Disable macOS keyboard focus navigation shortcuts (15..26) to avoid conflicts
for key in {15..26}; do
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$key" '<dict><key>enabled</key><false/></dict>'
done

# Enable Cmd+` (27) to cycle through windows of the current application
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 27 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>50</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>'

# Enable Input Source switching shortcuts (60 = Ctrl+Space, 61 = Ctrl+Opt+Space)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>786432</integer></array><key>type</key><string>standard</string></dict></dict>'

# Enable Move left/right a space shortcuts (79..82)
for key in 79 80 81 82; do
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$key" '<dict><key>enabled</key><true/></dict>'
done

# Disable Quick Note (190 = Fn+Q) and extra system hotkeys (164, 260)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 164 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>65535</integer><integer>0</integer></array><key>type</key><string>standard</string></dict></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 190 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>113</integer><integer>12</integer><integer>8388608</integer></array><key>type</key><string>standard</string></dict></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 260 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>53</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>'

defaults read com.apple.symbolichotkeys >/dev/null 2>&1 || true

# ------------------------------------------------------------------------------
# 6. Finder, Desktop Icons & Screenshot Defaults
# ------------------------------------------------------------------------------
echo "--> Enabling Finder QoL defaults (hidden files, extensions, folder sorting) & Screenshots..."
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder FXArrangeGroupViewBy -string "Name"
defaults write com.apple.finder RecentsArrangeGroupViewBy -string "Date Last Opened"
defaults write com.apple.finder FK_AppCentricShowSidebar -bool true
defaults write com.apple.finder SidebarDevicesSectionDisclosedState -bool true
defaults write com.apple.finder FXICloudDriveEnabled -bool false
defaults write com.apple.finder FXICloudDriveDesktop -bool false
defaults write com.apple.finder FXICloudDriveDocuments -bool false
defaults write com.apple.finder FontSizeCategory -string "M"

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Screenshot & Screen Recording preferences
defaults write com.apple.screencapture style -string "display"
defaults write com.apple.screencapture captureDelay -int 5
defaults write com.apple.screencapture showsCursor -bool true
defaults write com.apple.screencapture video -bool true
defaults write com.apple.screencapture target-screenshot -string "file"
defaults write com.apple.screencapture target-screenrecording -string "file"

# ------------------------------------------------------------------------------
# 7. Keyboard, Input Sources, Modifier Keys & Text Preferences
# ------------------------------------------------------------------------------
echo "--> Configuring Keyboard repeat rates, Press-and-Hold off, ABC layout & Modifier keys..."
# Fast repeat rate (2), initial delay (15 = ~225ms), and disable Press-and-Hold for key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write com.apple.Accessibility KeyRepeatEnabled -int 1

# Ensure standard ABC layout is default, Fn/Globe key does nothing (0), and hide Input menu from Menu Bar
defaults write com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID -string "com.apple.keylayout.ABC"
defaults write com.apple.HIToolbox AppleFnUsageType -int 0
defaults write com.apple.TextInputMenu visible -bool false
defaults write com.apple.TextInputMenuAgent "NSStatusItem VisibleCC Item-0" -bool false
defaults write com.apple.keyboard.preferences IsMixmojiSuggestionsEnabled -bool false

# Modifier key mappings (currentHost)
defaults -currentHost write NSGlobalDomain "com.apple.keyboard.modifiermapping.0-0-0" -array \
    '<dict><key>HIDKeyboardModifierMappingDst</key><integer>30064771300</integer><key>HIDKeyboardModifierMappingSrc</key><integer>1095216660483</integer></dict>' \
    '<dict><key>HIDKeyboardModifierMappingDst</key><integer>30064771296</integer><key>HIDKeyboardModifierMappingSrc</key><integer>280379760050179</integer></dict>'

# Locale & Language
defaults write NSGlobalDomain AppleLanguages -array "en-BR"
defaults write NSGlobalDomain AppleLocale -string "en_BR"

# Text substitutions (current system values: enabled)
set_or_warn "Configure Auto-Correct" \
    "Keyboard -> Input Sources (Edit) -> 'Correct spelling automatically'" \
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true

set_or_warn "Configure Auto-Capitalization" \
    "Keyboard -> Input Sources (Edit) -> 'Capitalize words automatically'" \
    defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool true

set_or_warn "Configure Double-Space Period" \
    "Keyboard -> Input Sources (Edit) -> 'Add period with double-space'" \
    defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool true

set_or_warn "Configure Smart Quotes & Dashes" \
    "Keyboard -> Input Sources (Edit) -> 'Use smart quotes and dashes'" \
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool true

# ------------------------------------------------------------------------------
# 8. Trackpad & Mouse Preferences
# ------------------------------------------------------------------------------
echo "--> Configuring Trackpad (Light click, speed 2.0, tap-to-click, gestures) & Mouse..."
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true
defaults write NSGlobalDomain com.apple.mouse.scaling -string "-1"
defaults write NSGlobalDomain com.apple.mouse.acceleration -string "-1"

defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2
set_or_warn "Trackpad Scroll Speed" \
    "Accessibility -> Pointer Control -> Trackpad Options... -> Scroll speed" \
    defaults write NSGlobalDomain com.apple.trackpad.scrolling -float 0.5882
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true

# Built-in & Bluetooth Multitouch Trackpad settings
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool false
defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -bool true

for tp_domain in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
    defaults write "$tp_domain" Clicking -bool true 2>/dev/null || true
    defaults write "$tp_domain" Dragging -bool true 2>/dev/null || true
    defaults write "$tp_domain" DragLock -bool true 2>/dev/null || true
    defaults write "$tp_domain" TrackpadRightClick -bool true 2>/dev/null || true
    defaults write "$tp_domain" TrackpadCornerSecondaryClick -int 0 2>/dev/null || true
    defaults write "$tp_domain" TrackpadHandResting -bool true 2>/dev/null || true
    defaults write "$tp_domain" TrackpadHorizScroll -bool true 2>/dev/null || true
    defaults write "$tp_domain" TrackpadMomentumScroll -bool true 2>/dev/null || true
    defaults write "$tp_domain" TrackpadPinch -bool true 2>/dev/null || true
    defaults write "$tp_domain" TrackpadRotate -bool false 2>/dev/null || true
    defaults write "$tp_domain" TrackpadScroll -bool true 2>/dev/null || true
    defaults write "$tp_domain" TrackpadThreeFingerDrag -bool false 2>/dev/null || true
    defaults write "$tp_domain" TrackpadThreeFingerHorizSwipeGesture -int 2 2>/dev/null || true
    defaults write "$tp_domain" TrackpadThreeFingerTapGesture -int 0 2>/dev/null || true
    defaults write "$tp_domain" TrackpadThreeFingerVertSwipeGesture -int 2 2>/dev/null || true
    defaults write "$tp_domain" TrackpadFourFingerHorizSwipeGesture -int 2 2>/dev/null || true
    defaults write "$tp_domain" TrackpadFourFingerPinchGesture -int 0 2>/dev/null || true
    defaults write "$tp_domain" TrackpadFourFingerVertSwipeGesture -int 2 2>/dev/null || true
    defaults write "$tp_domain" TrackpadFiveFingerPinchGesture -int 0 2>/dev/null || true
    defaults write "$tp_domain" TrackpadTwoFingerDoubleTapGesture -int 1 2>/dev/null || true
    defaults write "$tp_domain" TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3 2>/dev/null || true
    defaults write "$tp_domain" USBMouseStopsTrackpad -bool false 2>/dev/null || true
done

# CurrentHost Trackpad & Mouse gesture defaults
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 3
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fiveFingerPinchSwipeGesture -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerHorizSwipeGesture -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerPinchSwipeGesture -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerVertSwipeGesture -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.momentumScroll -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.pinchGesture -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.rotateGesture -bool false
defaults -currentHost write NSGlobalDomain com.apple.trackpad.scrollBehavior -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerDragGesture -bool false
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerTapGesture -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerVertSwipeGesture -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.twoFingerDoubleTapGesture -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.twoFingerFromRightEdgeSwipeGesture -int 3

# Multitouch & HID Mouse settings
for mouse_domain in com.apple.AppleMultitouchMouse com.apple.driver.AppleBluetoothMultitouch.mouse; do
    defaults write "$mouse_domain" MouseButtonDivision -int 55 2>/dev/null || true
    defaults write "$mouse_domain" MouseButtonMode -string "OneButton" 2>/dev/null || true
    defaults write "$mouse_domain" MouseHorizontalScroll -int 1 2>/dev/null || true
    defaults write "$mouse_domain" MouseMomentumScroll -int 1 2>/dev/null || true
    defaults write "$mouse_domain" MouseOneFingerDoubleTapGesture -int 0 2>/dev/null || true
    defaults write "$mouse_domain" MouseTwoFingerDoubleTapGesture -int 3 2>/dev/null || true
    defaults write "$mouse_domain" MouseTwoFingerHorizSwipeGesture -int 2 2>/dev/null || true
    defaults write "$mouse_domain" MouseVerticalScroll -int 1 2>/dev/null || true
done

# ------------------------------------------------------------------------------
# 9. Menu Bar & Control Center Preferences
# ------------------------------------------------------------------------------
echo "--> Configuring Menu Bar and Control Center items..."
# Hide Bluetooth, Timer, and Weather icons from Menu Bar (accessible via Control Center)
defaults -currentHost write com.apple.controlcenter Bluetooth -int 2
defaults -currentHost write com.apple.controlcenter Timer -int 2
defaults -currentHost write com.apple.controlcenter Weather -int 2

# Show Battery percentage & energy mode
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true
defaults -currentHost write com.apple.controlcenter BatteryShowEnergyMode -int 1

# Focus Modes, Display, Spotlight & Screen Mirroring in menu bar / control center
defaults -currentHost write com.apple.controlcenter Display -int 8
defaults -currentHost write com.apple.controlcenter FocusModes -int 8
defaults -currentHost write com.apple.controlcenter Spotlight -int 8
defaults -currentHost write com.apple.controlcenter ScreenMirroring -int 24
defaults -currentHost write com.apple.controlcenter ShowSuggestions -bool true
defaults -currentHost write com.apple.Spotlight MenuItemHidden -bool true

# Control Center grid layout & custom controls (Stopwatch, True Tone, Alarm)
defaults write com.apple.controlcenter BentoBoxCustomizationState -data "$(printf '%s' '{"MovedControlToMenuBar":false,"ResizedControl":false,"LastChangeDate":812996716.023437,"AddedControl":true,"CustomizedControl":false,"RemovedControl":true}' | xxd -p -c 0)"
defaults write com.apple.controlcenter ControlCenterDisplayableChronoControlsProviderConfiguration -data "$(printf '%s' '{"Controls":[{"ControlType":2,"Identifier":["E704DCFF-59E0-47E2-9641-DAF90CCD9FC5"],"ControlSize":0,"ControlIdentity":"YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGoCwwVHR4fJidVJG51bGzUDQ4PEBESExRZaW50ZW50UmVmVGtpbmRVZXh0SWRWJGNsYXNzgACABoACgAfUFhcYEBEaGxxfEBBkZXZpY2VJZGVudGlmaWVyXxAZY29udGFpbmVyQnVuZGxlSWRlbnRpZmllcl8QGWV4dGVuc2lvbkJ1bmRsZUlkZW50aWZpZXKAAIAEgAOABV8QIGNvbS5hcHBsZS5jbG9jay5Xb3JsZENsb2NrV2lkZ2V0XxAPY29tLmFwcGxlLmNsb2Nr0iAhIiNaJGNsYXNzbmFtZVgkY2xhc3Nlc18QFENIU0V4dGVuc2lvbklkZW50aXR5oiQlXxAUQ0hTRXh0ZW5zaW9uSWRlbnRpdHlYTlNPYmplY3RfECdjb20uYXBwbGUubW9iaWxldGltZXIuY29udHJvbC5zdG9wd2F0Y2jSICEoKV8QEkNIU0NvbnRyb2xJZGVudGl0eaIqJV8QEkNIU0NvbnRyb2xJZGVudGl0eQAIABEAGgAkACkAMgA3AEkATABRAFMAXABiAGsAdQB6AIAAhwCJAIsAjQCPAJgAqwDHAOMA5QDnAOkA6wEOASABJQEwATkBUAFTAWoBcwGdAaIBtwG6AAAAAAAAAgEAAAAAAAAAKwAAAAAAAAAAAAAAAAAAAc8=","ControlDescription":"Open the Clock app to track time with the stopwatch.","DisplayName":"Stopwatch","OverrideSizeForMenuBar":false,"PromptsForUserConfiguration":false},{"ControlType":1,"Identifier":["84EFA437-958F-4583-8C9E-4D69241A0F94"],"ControlSize":0,"ControlIdentity":"YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGoCwwVHR4fJidVJG51bGzUDQ4PEBESExRZaW50ZW50UmVmVGtpbmRVZXh0SWRWJGNsYXNzgACABoACgAfUFhcYEBEaGxxfEBBkZXZpY2VJZGVudGlmaWVyXxAZY29udGFpbmVyQnVuZGxlSWRlbnRpZmllcl8QGWV4dGVuc2lvbkJ1bmRsZUlkZW50aWZpZXKAAIAEgAOABV8QGmNvbS5hcHBsZS5jb250cm9scy5kaXNwbGF5XxAXY29tLmFwcGxlLmNvbnRyb2xjZW50ZXLSICEiI1okY2xhc3NuYW1lWCRjbGFzc2VzXxAUQ0hTRXh0ZW5zaW9uSWRlbnRpdHmiJCVfEBRDSFNFeHRlbnNpb25JZGVudGl0eVhOU09iamVjdF8QJGNvbS5hcHBsZS5jb250cm9scy5kaXNwbGF5LnRydWUtdG9uZdIgISgpXxASQ0hTQ29udHJvbElkZW50aXR5oiolXxASQ0hTQ29udHJvbElkZW50aXR5AAgAEQAaACQAKQAyADcASQBMAFEAUwBcAGIAawB1AHoAgACHAIkAiwCNAI8AmACrAMcA4wDlAOcA6QDrAQgBIgEnATIBOwFSAVUBbAF1AZwBoQG2AbkAAAAAAAACAQAAAAAAAAArAAAAAAAAAAAAAAAAAAABzg==","ControlDescription":"Toggle whether True Tone is enabled","DisplayName":"True Tone","OverrideSizeForMenuBar":false,"PromptsForUserConfiguration":false},{"ControlType":2,"Identifier":["D57F6F9C-07EF-42AD-83D2-26CD9471778B"],"ControlSize":0,"ControlIdentity":"YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGoCwwVHR4fJidVJG51bGzUDQ4PEBESExRZaW50ZW50UmVmVGtpbmRVZXh0SWRWJGNsYXNzgACABoACgAfUFhcYEBEaGxxfEBBkZXZpY2VJZGVudGlmaWVyXxAZY29udGFpbmVyQnVuZGxlSWRlbnRpZmllcl8QGWV4dGVuc2lvbkJ1bmRsZUlkZW50aWZpZXKAAIAEgAOABV8QIGNvbS5hcHBsZS5jbG9jay5Xb3JsZENsb2NrV2lkZ2V0XxAPY29tLmFwcGxlLmNsb2Nr0iAhIiNaJGNsYXNzbmFtZVgkY2xhc3Nlc18QFENIU0V4dGVuc2lvbklkZW50aXR5oiQlXxAUQ0hTRXh0ZW5zaW9uSWRlbnRpdHlYTlNPYmplY3RfECNjb20uYXBwbGUubW9iaWxldGltZXIuY29udHJvbC5hbGFybdIgISgpXxASQ0hTQ29udHJvbElkZW50aXR5oiolXxASQ0hTQ29udHJvbElkZW50aXR5AAgAEQAaACQAKQAyADcASQBMAFEAUwBcAGIAawB1AHoAgACHAIkAiwCNAI8AmACrAMcA4wDlAOcA6QDrAQ4BIAElATABOQFQAVMBagFzAZkBngGzAbYAAAAAAAACAQAAAAAAAAArAAAAAAAAAAAAAAAAAAAByw==","ControlDescription":"Open the Clock app to manage your alarms.","DisplayName":"Alarm","OverrideSizeForMenuBar":false,"PromptsForUserConfiguration":false}]}' | xxd -p -c 0)"
defaults -currentHost write com.apple.controlcenter.bentoboxes boxes -data "$(printf '%s' '[{"menuBarIconName":"circle.grid.2x2","grid":{"maxHeight":8,"unoccupiedLocations":[{"x":2,"y":7},{"x":3,"y":7},{"x":2,"y":6},{"x":3,"y":6}],"elements":[{"size":{"rect2x1":{}},"id":{"rawValue":"08ADB68C-7CB7-4C0C-9BE5-FFB19F56F53B"},"location":{"x":0,"y":0}},{"size":{"square2x2":{}},"id":{"rawValue":"B1BA8610-78BB-451F-BF04-A0B7CBDF42EF"},"location":{"x":2,"y":0}},{"size":{"rect2x1":{}},"id":{"rawValue":"8DA9C27F-6E00-4023-A596-F25D9C19C917"},"location":{"x":0,"y":1}},{"size":{"square1x1":{}},"id":{"rawValue":"21CE233B-1EB6-4730-90A7-ED89724CC776"},"location":{"x":3,"y":2}},{"size":{"rect2x1":{}},"id":{"rawValue":"E1A6983C-5A0D-4564-A920-88F6E8244214"},"location":{"x":2,"y":3}},{"size":{"rect4x1":{}},"id":{"rawValue":"26E5D221-ABC0-45C4-A572-2F1CA60F8BEE"},"location":{"x":0,"y":4}},{"size":{"rect4x1":{}},"id":{"rawValue":"7B1F4ABC-159B-41C4-8784-F1F47443A581"},"location":{"x":0,"y":5}},{"size":{"square1x1":{}},"id":{"rawValue":"84EFA437-958F-4583-8C9E-4D69241A0F94"},"location":{"x":2,"y":2}},{"size":{"rect2x1":{}},"id":{"rawValue":"64442A6E-3D9B-473D-91BE-ACB1A3421BDE"},"location":{"x":0,"y":3}},{"size":{"square2x2":{}},"id":{"rawValue":"9BD469C4-106A-48BA-83A8-FEAFBBF262C8"},"location":{"x":0,"y":6}},{"size":{"square1x1":{}},"id":{"rawValue":"E704DCFF-59E0-47E2-9641-DAF90CCD9FC5"},"location":{"x":0,"y":2}},{"size":{"square1x1":{}},"id":{"rawValue":"D57F6F9C-07EF-42AD-83D2-26CD9471778B"},"location":{"x":1,"y":2}}],"allLocations":[{"x":2,"y":7},{"x":3,"y":5},{"x":0,"y":0},{"x":0,"y":6},{"x":1,"y":1},{"x":3,"y":1},{"x":3,"y":7},{"x":0,"y":7},{"x":2,"y":2},{"x":2,"y":1},{"x":1,"y":7},{"x":2,"y":0},{"x":2,"y":6},{"x":2,"y":5},{"x":0,"y":4},{"x":1,"y":4},{"x":3,"y":4},{"x":1,"y":3},{"x":3,"y":6},{"x":1,"y":0},{"x":1,"y":2},{"x":3,"y":2},{"x":2,"y":3},{"x":0,"y":3},{"x":1,"y":6},{"x":1,"y":5},{"x":3,"y":0},{"x":3,"y":3},{"x":2,"y":4},{"x":0,"y":1},{"x":0,"y":2},{"x":0,"y":5}],"width":4,"occupiedLocations":[{"x":0,"y":4},{"x":0,"y":2},{"x":1,"y":5},{"x":2,"y":2},{"x":1,"y":4},{"x":2,"y":3},{"x":0,"y":5},{"x":1,"y":2},{"x":1,"y":3},{"x":1,"y":1},{"x":0,"y":3},{"x":3,"y":4},{"x":2,"y":4},{"x":3,"y":1},{"x":0,"y":1},{"x":0,"y":0},{"x":2,"y":0},{"x":1,"y":7},{"x":1,"y":6},{"x":1,"y":0},{"x":3,"y":5},{"x":0,"y":7},{"x":2,"y":1},{"x":3,"y":3},{"x":2,"y":5},{"x":3,"y":2},{"x":3,"y":0},{"x":0,"y":6}],"id":{"rawValue":0}},"displayablesData":"YnBsaXN0MDDTAQIDBD4\/W2luc3RhbmNlSWRzXmNocm9ub0NvbnRyb2xzV21vZHVsZXOvEBwFCAoMDhASFBYYGhweICIkJigqLC4wMjQ2ODo80QYHWHJhd1ZhbHVlXxAkQkE1NEUzMDQtOTg2Ni00NDBGLThCNzgtNTVENTg2MTEzNDk20QYJXxAkRTFBNjk4M0MtNUEwRC00NTY0LUE5MjAtODhGNkU4MjQ0MjE00QYLXxAkQjFCQTg2MTAtNzhCQi00NTFGLUJGMDQtQTBCN0NCREY0MkVG0QYNXxAkMjFDRTIzM0ItMUVCNi00NzMwLTkwQTctRUQ4OTcyNENDNzc20QYPXxAkNzBCNjNBNjEtQUI0Qi00QkVELUI4OTItRDc5QTBGMENEQzc00QYRXxAkODRFRkE0MzctOTU4Ri00NTgzLThDOUUtNEQ2OTI0MUEwRjk00QYTXxAkMjZFNUQyMjEtQUJDMC00NUM0LUE1NzItMkYxQ0E2MEY4QkVF0QYVXxAkMEIzMDI1N0QtQTg5Ny00NTUyLTg2NUEtRkQ1NDAxMzgwMkU20QYXXxAkNjIzRDQ3OEEtQUVEQi00NjUxLTk0QzQtQzkwMDlFNjQxN0E20QYZXxAkNjQ0NDJBNkUtM0Q5Qi00NzNELTkxQkUtQUNCMUEzNDIxQkRF0QYbXxAkQzE5RTU5NkMtQkU2NS00REJBLUFFMDAtNTlCODJBQjMwNjI30QYdXxAkNjRBMTMyMEItRDY4QS00QTM1LTlBOTMtNjE5NTQ2MzM0QTJG0QYfXxAkNjlDODhFQzctNDMxNi00MDZCLTgwNDQtMkJBMzc3RTkxQzFC0QYhXxAkRDU3RjZGOUMtMDdFRi00MkFELTgzRDItMjZDRDk0NzE3NzhC0QYjXxAkOUJENDY5QzQtMTA2QS00OEJBLTgzQTgtRkVBRkJCRjI2MkM40QYlXxAkOERBOUMyN0YtNkUwMC00MDIzLUE1OTYtRjI1RDlDMTlDOTE30QYnXxAkRTcwNERDRkYtNTlFMC00N0UyLTk2NDEtREFGOTBDQ0Q5RkM10QYpXxAkMERCMERGRkYtMDkzMS00NUY3LTg5NDctNUZCRDAwMTNFMzA20QYrXxAkMDhBREI2OEMtN0NCNy00QzBDLTlCRTUtRkZCMTlGNTZGNTNC0QYtXxAkMjVDRUY0MzItRDAwMi00NzgzLTlCNkItQzFDNjJCQTcwNEY50QYvXxAkN0IxRjRBQkMtMTU5Qi00MUM0LTg3ODQtRjFGNDc0NDNBNTgx0QYxXxAkMTcwQzJEMjktRkRDQy00OUYxLUFCN0QtMEMyRTJENDk0QTNF0QYzXxAkNDA0MUREREEtMDE1MS00NkZBLUFCNTgtMDM2RUNFRDk1MDYz0QY1XxAkNkNGN0NCQ0ItQTg2My00MkZCLThFMDItQUQ0REI1N0MxODYz0QY3XxAkRUQyRjczQkItQjZDNC00QzAxLUFFRkEtQTY5NUE5MzRBOENG0QY5XxAkMUY0OTAzMTEtMEY2Qy00MjI3LTk2MEItRjI4RkE3RDA4RTAw0QY7XxAkQkVEMTgwODctMjY0OC00RDRDLTgwRjItMEE4MDBGNDU2MkRB0QY9XxAkRjdBMzE3NEQtMDRFNi00N0JGLTlBRDUtNDBGQ0ZEODUzMDhCTxC7YnBsaXN0MDCjAQQG0QIDWHJhd1ZhbHVlXxAkODRFRkE0MzctOTU4Ri00NTgzLThDOUUtNEQ2OTI0MUEwRjk00QIFXxAkRDU3RjZGOUMtMDdFRi00MkFELTgzRDItMjZDRDk0NzE3NzhC0QIHXxAkRTcwNERDRkYtNTlFMC00N0UyLTk2NDEtREFGOTBDQ0Q5RkM1CAwPGD9CaWwAAAAAAAABAQAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAk08RBxxicGxpc3QwMK8QGQEMEhkgJSswNjxBR01SV1xhZmtwdXp\/hInTAgMEBQgLUmlkVHNpemVYbW9kdWxlSWTRBgdYcmF3VmFsdWVfECRCQTU0RTMwNC05ODY2LTQ0MEYtOEI3OC01NUQ1ODYxMTM0OTbRCQpWbWVkaXVt0FdBaXJEcm9w0wIDBA0PEdEGDl8QJEUxQTY5ODNDLTVBMEQtNDU2NC1BOTIwLTg4RjZFODI0NDIxNNEJENBaRm9jdXNNb2Rlc9MCAwQTFRjRBhRfECRCMUJBODYxMC03OEJCLTQ1MUYtQkYwNC1BMEI3Q0JERjQyRUbRFhdVbGFyZ2XQWk5vd1BsYXlpbmfTAgMEGhwf0QYbXxAkMjFDRTIzM0ItMUVCNi00NzMwLTkwQTctRUQ4OTcyNENDNzc20R0eVXNtYWxs0F8QD1NjcmVlbk1pcnJvcmluZ9MCAwQhIx\/RBiJfECQ3MEI2M0E2MS1BQjRCLTRCRUQtQjg5Mi1ENzlBMEYwQ0RDNzTRHSTQ0wIDBCYoKtEGJ18QJDI2RTVEMjIxLUFCQzAtNDVDNC1BNTcyLTJGMUNBNjBGOEJFRdEWKdBXRGlzcGxhedMCAwQsLh\/RBi1fECQwQjMwMjU3RC1BODk3LTQ1NTItODY1QS1GRDU0MDEzODAyRTbRHS\/Q0wIDBDEzNdEGMl8QJDYyM0Q0NzhBLUFFREItNDY1MS05NEM0LUM5MDA5RTY0MTdBNtEWNNBVU291bmTTAgMENzk70QY4XxAkNjQ0NDJBNkUtM0Q5Qi00NzNELTkxQkUtQUNCMUEzNDIxQkRF0Qk60F8QEktleWJvYXJkQnJpZ2h0bmVzc9MCAwQ9PyrRBj5fECRDMTlFNTk2Qy1CRTY1LTREQkEtQUUwMC01OUI4MkFCMzA2MjfRFkDQ0wIDBEJERtEGQ18QJDY0QTEzMjBCLUQ2OEEtNEEzNS05QTkzLTYxOTU0NjMzNEEyRtEJRdBZQmx1ZXRvb3Ro0wIDBEhKTNEGSV8QJDY5Qzg4RUM3LTQzMTYtNDA2Qi04MDQ0LTJCQTM3N0U5MUMxQtEJS9BUV2lGadMCAwROUBjRBk9fECQ5QkQ0NjlDNC0xMDZBLTQ4QkEtODNBOC1GRUFGQkJGMjYyQzjRFlHQ0wIDBFNVRtEGVF8QJDhEQTlDMjdGLTZFMDAtNDAyMy1BNTk2LUYyNUQ5QzE5QzkxN9EJVtDTAgMEWFpM0QZZXxAkMERCMERGRkYtMDkzMS00NUY3LTg5NDctNUZCRDAwMTNFMzA20Qlb0NMCAwRdX0zRBl5fECQwOEFEQjY4Qy03Q0I3LTRDMEMtOUJFNS1GRkIxOUY1NkY1M0LRCWDQ0wIDBGJkGNEGY18QJDI1Q0VGNDMyLUQwMDItNDc4My05QjZCLUMxQzYyQkE3MDRGOdEWZdDTAgMEZ2k10QZoXxAkN0IxRjRBQkMtMTU5Qi00MUM0LTg3ODQtRjFGNDc0NDNBNTgx0RZq0NMCAwRsbjXRBm1fECQxNzBDMkQyOS1GRENDLTQ5RjEtQUI3RC0wQzJFMkQ0OTRBM0XRFm\/Q0wIDBHFzGNEGcl8QJDQwNDFERERBLTAxNTEtNDZGQS1BQjU4LTAzNkVDRUQ5NTA2M9EWdNDTAgMEdngR0QZ3XxAkNkNGN0NCQ0ItQTg2My00MkZCLThFMDItQUQ0REI1N0MxODYz0Ql50NMCAwR7fUbRBnxfECRFRDJGNzNCQi1CNkM0LTRDMDEtQUVGQS1BNjk1QTkzNEE4Q0bRCX7Q0wIDBICCKtEGgV8QJDFGNDkwMzExLTBGNkMtNDIyNy05NjBCLUYyOEZBN0QwOEUwMNEWg9DTAgMEhYcR0QaGXxAkQkVEMTgwODctMjY0OC00RDRDLTgwRjItMEE4MDBGNDU2MkRB0QmI0NMCAwSKjAvRBotfECRGN0EzMTc0RC0wNEU2LTQ3QkYtOUFENS00MEZDRkQ4NTMwOELRCY3QAAgAJAArAC4AMwA8AD8ASABvAHIAeQB6AIIAiQCMALMAtgC3AMIAyQDMAPMA9gD8AP0BCAEPARIBOQE8AUIBQwFVAVwBXwGGAYkBigGRAZQBuwG+Ab8BxwHOAdEB+AH7AfwCAwIGAi0CMAIxAjcCPgJBAmgCawJsAoECiAKLArICtQK2Ar0CwALnAuoC6wL1AvwC\/wMmAykDKgMvAzYDOQNgA2MDZANrA24DlQOYA5kDoAOjA8oDzQPOA9UD2AP\/BAIEAwQKBA0ENAQ3BDgEPwRCBGkEbARtBHQEdwSeBKEEogSpBKwE0wTWBNcE3gThBQgFCwUMBRMFFgU9BUAFQQVIBUsFcgV1BXYFfQWABacFqgWrBbIFtQXcBd8AAAAAAAACAQAAAAAAAACOAAAAAAAAAAAAAAAAAAAF4AAIAA8AGwAqADIAUQBUAF0AhACHAK4AsQDYANsBAgEFASwBLwFWAVkBgAGDAaoBrQHUAdcB\/gIBAigCKwJSAlUCfAJ\/AqYCqQLQAtMC+gL9AyQDJwNOA1EDeAN7A6IDpQPMA88D9gP5BCAEIwRKBE0EdAR3BJ4EoQTIBMsE8gWwAAAAAAAAAgEAAAAAAAAAQAAAAAAAAAAAAAAAAAAADNA="}]' | xxd -p -c 0)"

# Clock format: Show AM/PM and Day of Week, hide Date
defaults write com.apple.menuextra.clock ShowAMPM -bool true
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowDate -int 0

# ------------------------------------------------------------------------------
# 10. Displays, External TV Mirroring & Night Shift
# ------------------------------------------------------------------------------
echo "--> Configuring Displays, resolution list, and Night Shift (Sunset to Sunrise)..."
set_or_warn "Show Display Resolutions as List" \
    "Displays -> Advanced... -> Turn ON 'Show resolutions as list'" \
    defaults write com.apple.preference.displays ShowAllResolutions -bool true

defaults write com.apple.airplay showInMenuBarIfPresent -bool true
defaults -currentHost write com.apple.windowserver.displays TVConnectPolicy -int 1

# Schedule Night Shift (Nightlight) from Sunset to Sunrise (mode 1, strength 0.5) via CoreBrightness
set_or_warn "Configure Night Shift (Sunset to Sunrise)" \
    "Displays -> Night Shift... -> Schedule: Sunset to Sunrise" \
    python3 -c "
import ctypes
libobjc = ctypes.cdll.LoadLibrary('/usr/lib/libobjc.A.dylib')
cb = ctypes.cdll.LoadLibrary('/System/Library/PrivateFrameworks/CoreBrightness.framework/CoreBrightness')

libobjc.objc_getClass.restype = ctypes.c_void_p
libobjc.sel_registerName.restype = ctypes.c_void_p
msgSend_addr = ctypes.cast(libobjc.objc_msgSend, ctypes.c_void_p).value

cls = libobjc.objc_getClass(b'CBBlueLightClient')
alloc_fn = ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p)(msgSend_addr)
obj = alloc_fn(cls, libobjc.sel_registerName(b'alloc'))
obj = alloc_fn(obj, libobjc.sel_registerName(b'init'))

# Mode 1 = Sunset to Sunrise
setMode_fn = ctypes.CFUNCTYPE(ctypes.c_bool, ctypes.c_void_p, ctypes.c_void_p, ctypes.c_int)(msgSend_addr)
res_mode = setMode_fn(obj, libobjc.sel_registerName(b'setMode:'), 1)

# Color temperature strength = 0.5 (midpoint)
setStrength_fn = ctypes.CFUNCTYPE(ctypes.c_bool, ctypes.c_void_p, ctypes.c_void_p, ctypes.c_float, ctypes.c_bool)(msgSend_addr)
res_strength = setStrength_fn(obj, libobjc.sel_registerName(b'setStrength:commit:'), 0.5, True)

if not res_mode:
    raise RuntimeError('Failed to configure Night Shift schedule')
"

# ------------------------------------------------------------------------------
# 11. Battery, Power Adapter & Sleep Timers (pmset)
# ------------------------------------------------------------------------------
echo "--> Configuring Battery & Power Adapter display sleep timers..."
set_or_warn "Battery & Power Adapter Sleep Timers (Battery: 2m display sleep; Adapter: 10m display sleep, no system sleep)" \
    "Lock Screen & Battery -> Set display off on battery to 2 mins, on power adapter to 10 mins, and prevent automatic sleeping on power adapter" \
    bash -c "sudo -n pmset -b displaysleep 2 sleep 1 disksleep 10 lessbright 1 lowpowermode 0 womp 0 && sudo -n pmset -c displaysleep 10 sleep 0 disksleep 10 lowpowermode 0 womp 1"

# ------------------------------------------------------------------------------
# 12. Spotlight, Privacy, AirDrop & Apple Intelligence
# ------------------------------------------------------------------------------
echo "--> Configuring Spotlight, Pasteboard history (off), AirDrop & Privacy..."
set_or_warn "Spotlight Pasteboard History" \
    "Spotlight -> Clipboard History -> Turn OFF" \
    defaults write com.apple.Spotlight PasteboardHistoryEnabled -bool false
defaults write com.apple.Spotlight PasteboardHistoryTimeout -int 28800
defaults write com.apple.Spotlight PasteboardHistoryVersion -int 3
defaults write com.apple.Spotlight SPPasteboardFTEEngaged -bool true

# AirDrop, Personalized Ads, Passwords & Apple Intelligence
set_or_warn "AirDrop Receiving Off" \
    "General -> AirDrop & Handoff -> AirDrop: Receiving Off" \
    defaults write com.apple.sharingd DiscoverableMode -string "Off"
set_or_warn "Disable Apple Personalized Advertising" \
    "Privacy & Security -> Apple Advertising -> Turn OFF 'Personalized Ads'" \
    defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false
defaults write com.apple.Passwords ShowServiceNamesInPasswords -bool true
defaults write com.apple.driver.AppleIRController DeviceEnabled -bool false
defaults write com.apple.assistant.backedup "Enable Offline Mode For Apple Intelligence" -bool false

# ------------------------------------------------------------------------------
# 13. Developer Tools & Utility App Defaults (AeroSpace, iTerm2)
# ------------------------------------------------------------------------------
echo "--> Configuring AeroSpace and iTerm2 preferences..."
# AeroSpace
defaults write bobko.aerospace displayStyle -string "i3Ordered"

# Login Items (System Settings > General > Login Items & Extensions)
# Exactly these apps auto-start at login; the list is cleared first so nothing
# else (Chrome, Google Chat, iTerm, kitty, ...) pops up on macOS startup.
echo "--> Configuring Login Items..."
LOGIN_ITEMS=(
  "/Applications/AeroSpace.app"
  "/Applications/Maccy.app"
)
osascript -e 'tell application "System Events" to delete every login item' >/dev/null 2>&1 || true
for app in "${LOGIN_ITEMS[@]}"; do
  [ -d "$app" ] || continue
  osascript -e "tell application \"System Events\" to make login item at end with properties {path:\"$app\", hidden:false}" >/dev/null 2>&1 || true
done

# iTerm2
defaults write com.googlecode.iterm2 LeftOption -int 2
defaults write com.googlecode.iterm2 RightOption -int 3
defaults write com.googlecode.iterm2 LeftCommand -int 7
defaults write com.googlecode.iterm2 RightCommand -int 8
defaults write com.googlecode.iterm2 LeftControl -int 11
defaults write com.googlecode.iterm2 RightControl -int 12
defaults write com.googlecode.iterm2 FunctionKey -int 10
defaults write com.googlecode.iterm2 UseBorder -bool false
defaults write com.googlecode.iterm2 AllowClipboardAccess -bool true
defaults write com.googlecode.iterm2 AllowSymbolicHotKeys -bool true
defaults write com.googlecode.iterm2 ForceKeyboard -bool true
defaults write com.googlecode.iterm2 KeyboardLocale -string "com.apple.keylayout.ABC"
defaults write com.googlecode.iterm2 ApplePressAndHoldEnabled -bool false
defaults write com.googlecode.iterm2 AppleWindowTabbingMode -string "manual"
defaults write com.googlecode.iterm2 SoundForEsc -bool false
defaults write com.googlecode.iterm2 VisualIndicatorForEsc -bool false
defaults write com.googlecode.iterm2 HapticFeedbackForEsc -bool false
defaults write com.googlecode.iterm2 NSScrollAnimationEnabled -bool false

# ------------------------------------------------------------------------------
# 14. Restart Affected macOS Services
# ------------------------------------------------------------------------------
echo "--> Restarting Finder, Dock, WallpaperAgent, and Control Center to apply changes..."
killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true
killall WallpaperAgent 2>/dev/null || true
killall ControlCenter 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo ""
echo "=========================================================================="
echo "macOS QoL defaults applied successfully!"
echo "Note: Log out and log back in for all keyboard, trackpad & display changes to take full effect."
echo "=========================================================================="

# ------------------------------------------------------------------------------
# 15. Manual Configuration Summary (for permission/SIP protected settings)
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
