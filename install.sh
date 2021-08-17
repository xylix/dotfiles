#/bin/bash
export DOTFILES=$HOME/dotfiles
cp -r --symbolic-link $DOTFILES/config/home/. $HOME/.

ipython profile create
rm -rf $HOME/.ipython/profile_default/startup
ln -s $DOTFILES/config/home/.ipython/profile_default/startup/ $HOME/.ipython/profile_default/startup

cp -r --symbolic-link $DOTFILES/config/dotconfig/. $HOME/.config/.
sudo cp -r --symbolic-link $DOTFILES/config/etc /etc
# Install my system wide services
sudo cp -r --symbolic-link $DOTFILES/config/systemd/system/* /etc/systemd/system/

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo "Install fd. Either apt install fd-find or brew install fd"
