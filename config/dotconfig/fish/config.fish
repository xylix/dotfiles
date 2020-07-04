set LC_ALL en_US.UTF-8
set HUSKY_USE_YARN

set EDITOR nvim
set LESS -r
set PATH $HOME/dotfiles/scripts $PATH
set PATH /usr/local/bin $PATH
set PATH $HOME/.local/bin $PATH
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.poetry/bin $PATH
set PATH $HOME/neovim/bin $PATH

# macos only
set PATH "/Applications/Postgres.app/Contents/Versions/latest/bin" $PATH
set -g fish_user_paths "/usr/local/opt/python@3.8/bin" $fish_user_paths

# Start an nvim trying to load Session from file in current dir
function sesh
    nvim -S Session.vim
end

function wordcount
    printf 'lines: %s, words: %s\n' (pbpaste | wc -l | string trim) (pbpaste | wc -w | string trim)
end
function fix
    $EDITOR -p (git diff --name-only | uniq)
end
function varsave
    echo Saving to variable $argv[1] value $$argv[1]
    set -U $argv[1] $$argv[1]
end

function docpandify
    pandoc --pdf-engine=xelatex -i $argv[1] -o $argv[1].pdf
end

function o-docpandify
    docpandify $argv[1]
    open $argv[1].pdf
end
