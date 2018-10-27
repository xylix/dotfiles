#/bin/bash
cd $HOME/dotfiles &&
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&
vim +PluginInstall +qall
ln -s $(pwd)/.gitconfig $HOME/.gitconfig;
ln -s $(pwd)/.vimrc $HOME/.vimrc;
curl https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim --create-dirs -o $HOME/.vim/colors/monokai.vim
mkdir -p $HOME/.vim/swapfiles
