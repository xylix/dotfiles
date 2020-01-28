export PATH=/usr/local/bin:$PATH
export PATH=$PATH:"$HOME/.cargo/bin:"
if [[ "$OSTYPE" == "darwin"* ]]; then 
    export PATH=$PATH:"$HOME/Library/Python/3.7/bin";
fi
export PATH="$HOME/.poetry/bin:$PATH"
export PATH=“/usr/local/texlive/2019basic/bin/x86_64-darwin/:$PATH”

export LC_ALL=en_US.UTF-8
export SONAR_TOKEN="6ca5fb0a1b7b68474ed8d274e4be7cd65eedd0e1"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home/

alias vim='nvim'
