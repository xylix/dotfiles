# Defined in /tmp/fish.XgsNYn/enable-i3-debug.fish @ line 1
function enable-i3-debug
	i3-msg 'debuglog on; shmlog on; reload'
end
