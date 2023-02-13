# Defined in /tmp/fish.lbVBaa/youtube-dl-audio.fish @ line 2
function youtube-dl-audio
	youtube-dl --audio-format best -x -ciw -o "%(title)s.%(ext)s" --add-metadata -v $argv[1]
end
