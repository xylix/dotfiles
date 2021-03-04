function update-rcc
	if test -d $HOME/Code/robocorp/rcc
		cd $HOME/Code/robocorp/rcc
		git pull
		rake build
		switch (uname)
			case Darwin
				cp $HOME/Code/robocorp/rcc/build/macos64/rcc $HOME/.local/bin/rcc
			case Linux	
				cp $HOME/Code/robocorp/rcc/build/linux64/rcc $HOME/.local/bin/rcc
		end
	else
		echo "No RCC repo cloned, skipping update-rcc"
	end
end
