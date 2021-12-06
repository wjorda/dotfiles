#!/bin/bash

set -euxo pipefail

PWD=$(pwd)

function ensure_brew_packages() {
  brew bundle --cleanup
}

function ensure_symlinks () {
  ln -sf ${PWD}/config.fish ~/.config/fish/config.fish
  ln -sf ${PWD}/.gitconfig ~/.gitconfig
}

function ensure_java () {
  JAVA_VERSION=$(java --version | grep jdk | awk '{print $2}')
  sudo ln -sf ${JAVA_HOME}/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/${JAVA_VERSION}
}

function ensure_android () {
  sdkmanager --package_file=android-requirements.txt
}

ensure_brew_packages
ensure_symlinks
ensure_java
ensure_android
