# Defined in /var/folders/xz/6y6sty192sbg2m3bb623z6hw0000gn/T//fish.fziPu0/update-rcc.fish @ line 2
function update-rcc
		cd /Users/kerkko/Code/robocorp/rcc
		git pull
		rake build
		cp /Users/kerkko/Code/robocorp/rcc/build/macos64/rcc /Users/kerkko/.local/bin/rcc
end
