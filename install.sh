#/bin/bash
export DOTFILES=$HOME/dotfiles
cp -r --symbolic-link $DOTFILES/config/home/. $HOME/.

cp -r --symbolic-link $DOTFILES/config/dotconfig/. $HOME/.config/.

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall

git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
