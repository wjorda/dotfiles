#!/bin/bash

PWD=$(pwd)

source ${PWD}/config.fish

function ensure_brew_packages() {
  brew bundle --cleanup
}

function ensure_symlinks () {
  ln -sf ${PWD}/config.fish ~/.config/fish/config.fish
}

function ensure_android () {
  sdkmanager --package_file=android-requirements.txt
}

ensure_brew_packages
ensure_symlinks
ensure_android
