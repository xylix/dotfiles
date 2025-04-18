set -gx LC_ALL en_US.UTF-8
set -gx HUSKY_USE_YARN
# set -gx PLAYWRIGHT_BROWSERS_PATH /Users/kerkko/.robocorp/blobs

set -gx EDITOR nvim
set -gx LESS -r
set -gx GPG_TTY (tty)
set -gx HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK 1
set PATH $HOME/dotfiles/scripts $PATH
set PATH $HOME/.local/bin $PATH
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/neovim/bin $PATH
set PATH $HOME/go/bin $PATH
# Set a socket for neovim-remote usage
# set -gx NVIM_LISTEN_ADDRESS /tmp/nvimsocket

# Override fish intro greeting
set fish_greeting

# arm homebrew config (could also set in /etc/paths, but that might affect which binaries system applications look for first)
set PATH /opt/homebrew/bin $PATH
# intel brew alias on macos with both installed, no longer necessary
# alias ibrew 'arch -x86_64 /usr/local/bin/brew'

alias python python3

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval /Users/kerkko/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# Start an nvim trying to load Session from file in current dir
function sesh
    nvim -S Session.vim
end

function v
    if test -d .venv
        source .venv/bin/activate.fish
    else if test -d venv
        source venv/bin/activate.fish
    else
        echo "No Python venv available"
    end
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

function ncdu
    echo "use dua"
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /Users/xylix/.ghcup/bin # ghcup-env

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/xylix/.lmstudio/bin
