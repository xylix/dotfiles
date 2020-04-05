# Aliases
function aw-plan 
    nvim ~/Google\ Drive/activitywatch/plan.md
end

function git-lines 
    git diff --stat 4b825dc642cb6eb9a060e54bf8d69288fbee4904
end

# Brew

function bubo; brew update && brew outdated; end
function bubc; brew upgrade && brew cleanup; end

# python
function pdb
    python -m pdb $argv
end
function ppjson
    python -m json.tool $argv
end
function pydoc
    python -m pydoc $argv
end

# Git
function gst; git status; end
function gp; git push; end
function gpl; git pull; end
function gc; git commit -v; end
function ga; git add $argv; end
function gsw; git switch $argv; end
