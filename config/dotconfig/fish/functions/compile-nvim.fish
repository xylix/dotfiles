# Defined in /tmp/fish.AqAZ1X/update-nvim.fish @ line 2
function update-nvim
    cd $HOME/Code/ide-stuff/neovim
    git pull
    make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
    make install
end
