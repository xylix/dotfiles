if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

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
