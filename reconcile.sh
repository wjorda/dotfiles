#!/bin/bash

set -euxo pipefail

PWD=$(pwd)

function ensure_brew_packages() {
  brew bundle --cleanup
}

function ensure_symlinks () {
  ln -sf ${PWD}/config.fish ~/.config/fish/config.fish
  ln -sf ${PWD}/.gitconfig ~/.gitconfig
  ln -sf ${PWD}/.bashrc ~/.bashrc
  source ~/.bashrc
}

function ensure_java () {
  sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
}

function ensure_android () {
  sdkmanager --package_file=android-requirements.txt
}

ensure_brew_packages
ensure_symlinks
ensure_java
ensure_android
