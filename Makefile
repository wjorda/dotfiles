SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

export JAVA_HOME:=/usr/local/opt/openjdk

LOCKFILES := \
	Brewfile.lock.json \
	stow.txt \
	android.lock \
	softwareupdate-history.txt \
	pip.lock

STOW_PACKAGES := $(wildcard */)
DOTFILES := $(shell git ls-files $(STOW_PACKAGES))

all: update

clean:
	$(RM) $(LOCKFILES)

update: system brew symlinks java android python
upgrade: clean all
commit:
	git cm . -m "Patching $(shell date)"
	git push

brew: Brewfile.lock.json
symlinks: brew stow.txt
java: brew /Library/Java/JavaVirtualMachines/openjdk.jdk
android: brew java android.lock
python: brew pip.lock
system: softwareupdate-history.txt

Brewfile.lock.json: Brewfile
	brew bundle --cleanup

stow.txt: $(DOTFILES)
	stow --verbose --target $(HOME) $(STOW_PACKAGES)
	echo $^ > $@

/Library/Java/JavaVirtualMachines/openjdk.jdk: /usr/local/opt/openjdk/libexec/openjdk.jdk
	sudo ln -sfn $^ $@

android.lock: android-requirements.txt
	sdkmanager --package_file=$^
	sdkmanager --list_installed --include_obsolete > $@

softwareupdate-history.txt:
	softwareupdate -ia
	softwareupdate --history > $@

pip.lock: requirements.txt
	pip install -r $^
	pip freeze --all > $@

