#/bin/bash
export DOTFILES=/home/xylix/dotfiles
cp -r --symbolic-link $DOTFILES/config/home/* $HOME/.

cp -r --symbolic-link $DOTFILES/config/dotconfig/* $HOME/.config/.

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

mkdir -p $HOME/.vim/swapfiles
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&
vim +PluginInstall +qall
