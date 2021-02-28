# Defined in /tmp/fish.B3QMZI/update-rcc.fish @ line 2
function update-rcc
	if test -d $HOME/Code/robocorp/rcc
		cd /Users/kerkko/Code/robocorp/rcc
		git pull
		rake build
		cp /Users/kerkko/Code/robocorp/rcc/build/macos64/rcc /Users/kerkko/.local/bin/rcc
	else
		echo "No RCC repo cloned, skipping update-rcc"
	end
end
