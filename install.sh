#!/bin/sh

PWD=$(pwd)

ln -sf ${PWD}/config.fish ~/.config/fish/config.fish
ln -sf ${PWD}/Brewfile ~/Brewfile
ln -sf ${PWD}/Brewfile.lock.json ~/Brewfile.lock.json