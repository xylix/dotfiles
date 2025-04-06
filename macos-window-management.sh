# source: https://lilysthings.org/blog/tiling-macos/ + 

brew install koekeishiya/formulae/skhd
skhd --start-service
# Disable SIP (partially) https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection
brew install yabai
# load scripting addons etc.

brew tap FelixKratz/formulae
brew install sketchybar
# and the other steps from https://felixkratz.github.io/SketchyBar/setup
