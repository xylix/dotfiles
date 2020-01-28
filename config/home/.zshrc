# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gallois"

# ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

source $ZSH/oh-my-zsh.sh

source $HOME/.zprofile

rubberate() {
    rubber --pdf $1
    rubber --clean $1
}

docpandify() {
    pandoc --pdf-engine=xelatex -i $1 -o $1.pdf 
}

o-docpandify() {
    docpandify $1
    open $1.pdf
}
