# Defined in /var/folders/xz/6y6sty192sbg2m3bb623z6hw0000gn/T//fish.rpvMcB/update-nvim.fish @ line 2
function update-nvim
    nvim +PlugUpgrade +PlugUpdate +PlugClean +CocUpdate +qall
end
