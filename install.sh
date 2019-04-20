#/bin/bash
ln -s .gitconfig $HOME/.gitconfig;
ln -s .xinitrc $HOME/.xinitrc

mkdir -p $HOME/.config/i3
mkdir -p $HOME/.config/i3status
mkdir -p $HOME/.config/rofi/config
ln -s config/i3/config $HOME/.config/i3/config
ln -s config/i3status/config $HOME/.config/i3status/config
ln -s config/rofi/config $HOME/.config/rofi/config

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s config/zshrc $HOME/.zshrc
ln -s config/.zprofile $HOME/.zprofile

ln -s $HOME/.vimrc $HOME/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&
vim +PluginInstall +qall
curl https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim --create-dirs -o $HOME/.vim/colors/monokai.vim
mkdir -p $HOME/.vim/swapfiles
