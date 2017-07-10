#/bin/bash
cd $HOME/dotfiles
ln -s $(pwd)/.gitconfig $HOME/.gitconfig
ln -s $(pwd)/.vimrc $HOME/.vimrc
curl https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim --create-dirs -o $HOME/.vim/colors/monokai.vim
