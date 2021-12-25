export LC_ALL=en_US.UTF-8
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:"$HOME/.cargo/bin:"
export PATH="$HOME/.poetry/bin:$PATH"

if [[ "$OSTYPE" == "darwin"* ]]; then 
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home/
fi

