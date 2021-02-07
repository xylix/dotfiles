# Defined in /var/folders/xz/6y6sty192sbg2m3bb623z6hw0000gn/T//fish.Z8xRbd/update-nvim.fish @ line 2
function update-nvim
    nvim +PlugUpgrade +PlugUpdate +PlugClean +TSUpdate +CocUpdate
end
