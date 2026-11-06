# source: https://lilysthings.org/blog/tiling-macos/

# yabai and skhd are intentionally no longer installed. yabai's active CGEvent tap
# on mouse events stalled the pointer and scroll input system-wide whenever a second
# macOS account was logged in, and it needs SIP partially disabled. skhd only existed
# to drive yabai. If they ever come back: brew install koekeishiya/formulae/skhd yabai,
# and restore config/dotconfig/{yabai,skhd} from git history.
# To remove them from a machine that still has them:
#   yabai --stop-service && yabai --uninstall-service && sudo yabai --uninstall-sa
#   skhd --stop-service && skhd --uninstall-service

brew tap FelixKratz/formulae
brew install sketchybar
brew services start sketchybar
# and the other steps from https://felixkratz.github.io/SketchyBar/setup
