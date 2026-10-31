#!/usr/bin/env bash
# Symlink the dotfiles into place. Works on macOS and Linux (plain ln only).
# Not re-runnable by design: ln refuses to replace an existing target, so the
# script stops at the first conflict instead of overwriting anything.
set -euo pipefail
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

link_contents() {   # link_contents SRC_DIR DEST_DIR
    local src=$1 dest=$2 path
    mkdir -p "$dest"
    for path in "$src"/* "$src"/.[!.]* "$src"/..?*; do
        [ -e "$path" ] || continue   # unmatched glob left as literal text
        [ "$(basename "$path")" = .ssh ] && continue   # handled below
        ln -sn "$path" "$dest/$(basename "$path")"
    done
}

link_contents "$DOTFILES/config/home"      "$HOME"
link_contents "$DOTFILES/config/dotconfig" "$HOME/.config"

# ~/.ssh stays a real directory so keys and known_hosts never enter the repo.
mkdir -m 700 -p "$HOME/.ssh"
ln -sn "$DOTFILES/config/home/.ssh/config" "$HOME/.ssh/config"

# System-wide files are real copies: polkitd cannot follow symlinks into $HOME.
if [ "$(uname)" = Linux ]; then
    sudo install -m 644 "$DOTFILES/config/etc/logid.cfg" /etc/logid.cfg
    sudo install -Dm 644 "$DOTFILES/config/etc/polkit-1/rules.d/00.custom.rules" \
        /etc/polkit-1/rules.d/00.custom.rules
    # Install my system wide services
    # sudo install -m 644 "$DOTFILES"/config/systemd/system/* /etc/systemd/system/
fi

nvim --headless "+Lazy! restore" +qa   # install plugins pinned in lazy-lock.json, no UI
# coc installs missing g:coc_global_extensions itself; this waits for it to finish.
nvim --headless -c "source $DOTFILES/config/dotconfig/nvim/coc-headless-install.vim"
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo "Install rust"
echo "Install fd, fzf, Python, make (base-devel or setuptools)"
