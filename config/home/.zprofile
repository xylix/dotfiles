alias vim="nvim"

export LC_ALL=en_US.UTF-8
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:"$HOME/.cargo/bin:"
if [[ "$OSTYPE" == "darwin"* ]]; then 
    export PATH=$PATH:"$HOME/Library/Python/3.7/bin";
fi
export PATH="$HOME/.poetry/bin:$PATH"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home/
