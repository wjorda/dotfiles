export JAVA_HOME=/usr/local/opt/openjdk
export ANDROID_HOME=~/Library/Android/sdk
export NDK_HOME=$ANDROID_HOME/ndk/22.1.7171670

# android sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools/

# rustup
export CARGO_HOME=$HOME/.cargo
export PATH=$CARGO_HOME/bin:$PATH

# python
export PYTHON_HOME="/usr/local/opt/python@3.10/"
export PATH="$PYTHON_HOME/libexec/bin:$PATH"

# random bin's
export PATH=$HOME/bin:$PATH
