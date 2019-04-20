#/bin/bash
cp --symbolic-link config/home/* $HOME/. 

mkdir -p $HOME/.config/i3
mkdir -p $HOME/.config/i3status
mkdir -p $HOME/.config/rofi/config

cp --symbolic-link config/dotconfig/* $HOME/.config/.

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

mkdir -p $HOME/.vim/swapfiles
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&
vim +PluginInstall +qall
curl https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim --create-dirs -o $HOME/.vim/colors/monokai.vim
