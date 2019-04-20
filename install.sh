#/bin/bash
ln -s $HOME/.gitconfig $HOME/.gitconfig;
mkdir -p $HOME/.config/i3
mkdir -p $HOME/.config/i3status
ln -s config/i3/config $HOME/.config/i3/config
ln -s config/i3status/config $HOME/.config/i3status/config
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s .zshrc $HOME/.zshrc
ln -s $HOME/.vimrc $HOME/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&
vim +PluginInstall +qall
curl https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim --create-dirs -o $HOME/.vim/colors/monokai.vim
mkdir -p $HOME/.vim/swapfiles
