# Defined in /tmp/fish.rU7myg/ffmpeg-get-metadata.fish @ line 2
function ffmpeg-get-metadata
	ffmpeg -i $argv[1] -f ffmetadata -
end
