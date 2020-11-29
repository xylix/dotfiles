#/bin/bash
export DOTFILES=$HOME/dotfiles
cp -r --symbolic-link $DOTFILES/config/home/. $HOME/.

cp -r --symbolic-link $DOTFILES/config/dotconfig/. $HOME/.config/.

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
