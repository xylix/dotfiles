# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gallois"

# ENABLE_CORRECTION="true"

# Plugins to load
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Gitfast gives faster git promp & tab completion. Escape-magic auto-escapes symbols in git commands
# Node adds node-docs command for easier node documentation access
# Brew adds aliases, including `bubo` for update & list outdated and `bubc` for upgrade and cleanup
# Z adds `z <regex>` syntax for fast goto's into frequently visited directories / files
plugins=(git gitfast git-escape-magic node brew z zsh-syntax-highlighting)

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

source $ZSH/oh-my-zsh.sh
source $HOME/.zprofile
alias vim="nvim"

aw-plan() { nvim ~/Google\ Drive/activitywatch/plan.md }
git-lines() { git diff --stat 4b825dc642cb6eb9a060e54bf8d69288fbee4904 }
docpandify() { pandoc --pdf-engine=xelatex -i $1 -o $1.pdf }
o-docpandify() {
    docpandify $1
    open $1.pdf
}
# added by travis gem
[ -f /Users/xylix/.travis/travis.sh ] && source /Users/xylix/.travis/travis.sh
