set LC_ALL en_US.UTF-8

set EDITOR nvim
set LESS -r
set PATH $HOME/dotfiles/scripts $PATH
set PATH /usr/local/bin $PATH
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.poetry/bin $PATH
set PATH $HOME/neovim/bin $PATH

set -g fisher_path $HOME/.fisher-packages
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]
for file in $fisher_path/conf.d/*.fish
    builtin source $file 2> /dev/null
end

if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo $fisher_path/functions/fisher.fish
    fish -c fisher
end

# Start an nvim trying to load Session from file in current dir
function sesh
    nvim -S Session.vim
end

function wordcount
    printf 'lines: %s, words: %s\n' (pbpaste | wc -l | string trim) (pbpaste | wc -w | string trim)
end

function varsave
    echo Saving to variable $argv[1] value $$argv[1]
    set -U $argv[1] $$argv[1]
end

# Aliases
function aw-plan 
    nvim ~/Google\ Drive/activitywatch/plan.md
end


function git-lines 
    git diff --stat 4b825dc642cb6eb9a060e54bf8d69288fbee4904
end

function docpandify
    pandoc --pdf-engine=xelatex -i $argv[1] -o $argv[1].pdf
end

function o-docpandify
    docpandify $argv[1]
    open $argv[1].pdf
end

function bubo; brew update && brew outdated; end
function bubc; brew upgrade && brew cleanup; end

# python Aliases
function pdb; python -m pdb; end
function ppjson; python -m json.tool; end
function pydoc; python -m pydo; end

# Git aliases
function gst; git status; end
function gp; git push; end
function gpl; git pull; end
function gc; git commit -v; end
function ga; git add $argv; end
function gsw; git switch $argv; end
