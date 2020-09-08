#/bin/bash
export DOTFILES=$HOME/dotfiles
gcp -r --symbolic-link $DOTFILES/config/home/* $HOME/
gcp -r --symbolic-link $DOTFILES/config/home/.* $HOME/

gcp -r --symbolic-link $DOTFILES/config/dotconfig/* $HOME/.config/
gcp -r --symbolic-link $DOTFILES/config/dotconfig/.* $HOME/.config/

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
