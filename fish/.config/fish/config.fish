set -x JAVA_HOME /usr/local/opt/openjdk
set -x ANDROID_HOME ~/Library/Android/sdk
set -x NDK_HOME $ANDROID_HOME/ndk/22.1.7171670

# android sdk
set -x PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin $ANDROID_HOME/platform-tools/

# rustup
set -x CARGO_HOME $HOME/.cargo
set -x PATH $CARGO_HOME/bin $PATH 

# python
set -x PYTHON_HOME /usr/local/opt/python@3.10/
set -x PATH $PYTHON_HOME/libexec/bin $PATH

# go
set -x PATH $HOME/go/bin $PATH

# random bin's
set -x PATH $HOME/bin $PATH 

function password
	LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&' </dev/urandom | head -c $argv[1]  ; echo
end

alias tba 'restish tba'
