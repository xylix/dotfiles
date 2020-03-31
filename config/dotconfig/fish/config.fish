set LC_ALL en_US.UTF-8

set EDITOR nvim
set PATH /usr/local/bin $PATH
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.poetry/bin $PATH


if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Aliases
function aw-plan 
    nvim ~/Google\ Drive/activitywatch/plan.md
end

function git-lines 
    git diff --stat 4b825dc642cb6eb9a060e54bf8d69288fbee4904
end

function docpandify
    pandoc --pdf-engine=xelatex -i $1 -o $1.pdf
end

function o-docpandify
    docpandify $1
    open $1.pdf
end

function bubo
    brew update && brew outdated
end
function bubc 
    brew upgrade && brew cleanup
end

# Git aliases
function gst
    git status
end
function gp
    git push
end
function gpl
    git pull
end
function gc
    git commit -v
end
function ga
    git add $argv
end
function gsw
    git switch $argv
end
