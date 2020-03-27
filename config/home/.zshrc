# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gallois"

# ENABLE_CORRECTION="true"

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
