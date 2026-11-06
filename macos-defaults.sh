#!/usr/bin/env bash
# macOS user defaults, extracted from the xylix account in Oct 2026 and trimmed
# in review. Idempotent: safe to re-run. Called from install.sh on Darwin.
set -euo pipefail
[ "$(uname)" = Darwin ] || { echo "macos-defaults.sh: not macOS, skipping"; exit 0; }

# System Settings overwrites defaults it has open, so close it first.
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

##### Locale and units ########################################################
defaults write -g AppleLanguages -array "en-US" "en-FI" "fi-FI"
defaults write -g AppleLocale -string "en_US@rg=fizzzz"   # US English, Finnish region
defaults write -g AppleMeasurementUnits -string "Centimeters"
defaults write -g AppleMetricUnits -bool true
defaults write -g AppleTemperatureUnit -string "Celsius"

##### Appearance ##############################################################
defaults write -g AppleInterfaceStyle -string "Dark"
defaults delete -g AppleInterfaceStyleSwitchesAutomatically 2>/dev/null || true
defaults write -g AppleAccentColor -int 5                       # purple; highlight colour follows it
defaults write -g _HIHideMenuBar -bool true                     # auto-hide menu bar (sketchybar replaces it)
defaults write -g AppleScrollerPagingBehavior -bool true        # click in scrollbar jumps to that spot
defaults write -g AppleWindowTabbingMode -string "always"       # open documents in tabs
defaults write -g NSQuitAlwaysKeepsWindows -bool true           # reopen windows when relaunching an app
defaults write -g CGDisableCursorLocationMagnification -bool true   # no "shake mouse to locate" blow-up
defaults write -g NavPanelFileListModeForOpenMode -int 2        # Open/Save dialogs start in list view

##### Keyboard ################################################################
defaults write -g KeyRepeat -int 2                 # fastest repeat
defaults write -g InitialKeyRepeat -int 15         # shortest delay
defaults write -g com.apple.keyboard.fnState -bool true   # F1-F12 are plain function keys; hold Fn for media

# No autocorrect, auto-capitalise, inline predictions or web autocorrect.
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticInlinePredictionEnabled -bool false
defaults write -g WebAutomaticSpellingCorrectionEnabled -bool false

# Caps Lock -> Escape on the built-in keyboard. hidutil applies it now; the
# per-device default is what System Settings writes, so it survives reboots.
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}' >/dev/null
hidutil list 2>/dev/null | awk '/Apple Internal Keyboard/ {print $1, $2}' | sort -u | while read -r vendor product; do
    defaults -currentHost write -g "com.apple.keyboard.modifiermapping.$((vendor))-$((product))-0" -array \
        '<dict><key>HIDKeyboardModifierMappingDst</key><integer>30064771113</integer><key>HIDKeyboardModifierMappingSrc</key><integer>30064771129</integer></dict>'
done

# Keyboard shortcuts (com.apple.symbolichotkeys IDs):
#   64       Cmd+Space Spotlight -> off, Alfred takes the key
#   118/119  Ctrl+1 / Ctrl+2     -> on, jump to desktop 1 / 2
sym=com.apple.symbolichotkeys
defaults write $sym AppleSymbolicHotKeys -dict-add 64 '<dict><key>enabled</key><false/></dict>'
for pair in "118 18" "119 19"; do
    set -- $pair
    defaults write $sym AppleSymbolicHotKeys -dict-add "$1" \
        "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>$2</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>"
done

##### Trackpad and mouse ######################################################
for domain in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
    defaults write $domain Clicking -bool true                   # tap to click
    defaults write $domain HIDScrollZoomModifierMask -int 262144 # Ctrl+scroll zooms the screen
done
defaults write -g AppleEnableSwipeNavigateWithScrolls -bool false  # no two-finger back/forward in browsers
# Screen zoom with Ctrl+scroll. This domain is protected: the terminal needs
# Full Disk Access or these two lines fail, so they are allowed to.
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true 2>/dev/null || echo "note: grant Full Disk Access to set Ctrl+scroll zoom"
defaults write com.apple.universalaccess closeViewScrollWheelModifiersInt -int 262144 2>/dev/null || true

##### Dock and Mission Control ################################################
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0   # no slide animation
defaults write com.apple.dock mineffect -string scale
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mru-spaces -bool false              # keep spaces in fixed order
defaults write com.apple.dock enterMissionControlByTopWindowDrag -bool false

##### Window management #######################################################
defaults write com.apple.WindowManager GloballyEnabled -bool false   # Stage Manager off

##### Menu bar ################################################################
defaults write com.apple.menuextra.clock Show24Hour -bool true
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock IsAnalog -bool false
defaults write com.apple.TextInputMenu visible -bool false     # hide input-source menu
defaults write com.apple.Siri StatusMenuVisible -bool false

##### Finder ##################################################################
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowSidebar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string icnv   # icon view
defaults write com.apple.finder FXPreferredGroupBy -string None

##### Screenshots #############################################################
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"

##### Bundled apps ############################################################
defaults write com.apple.DiskUtility SidebarShowAllDevices -bool true

##### Third-party apps (only if installed) ####################################
if [ -d /Applications/Rectangle.app ]; then
    defaults write com.knollsoft.Rectangle alternateDefaultShortcuts -bool true   # Ctrl+Option scheme
    defaults write com.knollsoft.Rectangle launchOnLogin -bool true
    defaults write com.knollsoft.Rectangle windowSnapping -int 2                  # drag-to-edge snapping off
    defaults write com.knollsoft.Rectangle subsequentExecutionMode -int 0
    defaults write com.knollsoft.Rectangle SUSendProfileInfo -bool false
fi

##### Apply ###################################################################
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u 2>/dev/null || true
for app in Dock Finder SystemUIServer ControlCenter; do
    killall "$app" 2>/dev/null || true
done
echo "macos-defaults.sh: done. Log out and back in for keyboard and menu bar changes to fully apply."
