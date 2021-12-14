set -gx LC_ALL en_US.UTF-8
set -gx HUSKY_USE_YARN
# set -gx PLAYWRIGHT_BROWSERS_PATH /Users/kerkko/.robocorp/blobs

set -gx EDITOR nvim
set -gx LESS -r
set -gx GPG_TTY (tty)
set PATH $HOME/dotfiles/scripts $PATH
set PATH $HOME/.local/bin $PATH
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.poetry/bin $PATH
set PATH $HOME/neovim/bin $PATH
# Set a socket for neovim-remote usage
set -gx NVIM_LISTEN_ADDRESS /tmp/nvimsocket 

# Override fish intro greeting
set fish_greeting

# macos only
set PATH "/Applications/Postgres.app/Contents/Versions/latest/bin" $PATH
# arm homebrew config
set PATH /opt/homebrew/bin $PATH
alias ibrew 'arch -x86_64 /usr/local/bin/brew'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval /Users/kerkko/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# Start an nvim trying to load Session from file in current dir
function sesh
    nvim -S Session.vim
end

function v
    source .venv/bin/activate.fish
    nvm use
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
