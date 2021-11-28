set -x JAVA_HOME /usr/local/Cellar/openjdk/17.0.1
set -x ANDROID_HOME ~/Library/Android/sdk
set -x NDK_HOME $ANDROID_HOME/ndk/22.1.7171670

# android sdk
set -x PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin $ANDROID_HOME/sdk/platform-tools/

# rustup
set -x PATH $PATH $HOME/.cargo/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
end
