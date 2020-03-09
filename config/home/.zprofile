export LC_ALL=en_US.UTF-8

export PATH=/usr/local/bin:$PATH
export PATH=$PATH:"$HOME/.cargo/bin:"
if [[ "$OSTYPE" == "darwin"* ]]; then 
    export PATH=$PATH:"$HOME/Library/Python/3.7/bin";
fi
export PATH="$HOME/.poetry/bin:$PATH"

#macOS specific
# MacPorts Installer addition on 2020-03-06_at_18:07:49: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home/
