# Defined in /tmp/fish.4anXo4/gdiff-without-lockfiles.fish @ line 2
function gdiff-without-lockfiles
	git diff $argv -- . ':(exclude)**/package-lock.json' ':(exclude)**/yarn.lock'
end
