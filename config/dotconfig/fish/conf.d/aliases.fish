# Aliases
function aw-plan 
    nvim ~/Google\ Drive/activitywatch/plan.md
end

function git-lines 
    git diff --stat 4b825dc642cb6eb9a060e54bf8d69288fbee4904 $argv
end

# Brew

function bubo; brew update && brew outdated; end
function bubc; brew upgrade --fetch-HEAD && brew cleanup; end

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
function git-conflicts; git diff --name-only --diff-filter=U ; end

function gst; git status ; end
function gpsh; git push ; end
function gpu; git pull ; end
function gc; git commit -v ; end
function ga; git add $argv ; end
function gsw; git switch $argv ; end
