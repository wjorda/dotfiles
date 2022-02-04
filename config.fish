set -x JAVA_HOME /usr/local/Cellar/openjdk/17.0.2/
set -x ANDROID_HOME ~/Library/Android/sdk
set -x NDK_HOME $ANDROID_HOME/ndk/22.1.7171670

# android sdk
set -x PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin $ANDROID_HOME/platform-tools/

# rustup
set -x PATH $PATH $HOME/.cargo/bin

# random bin's
set -x PATH $PATH $HOME/bin

function password
	LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&' </dev/urandom | head -c $argv[1]  ; echo
end
