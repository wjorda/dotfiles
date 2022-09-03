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
	$(RM) .tmp*

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

.tmp_android_wanted: android-requirements.txt
	cat $^ | sort | uniq > $@
	
.tmp_android_installed: android-requirements.txt
	sdkmanager --list_installed --include_obsolete --verbose | grep '^[a-z]'| sort | uniq > $@
	
.tmp_android_remove: .tmp_android_wanted .tmp_android_installed
	comm -13 $^ > $@
 
android.lock: .tmp_android_wanted .tmp_android_remove
	sdkmanager --package_file=.tmp_android_wanted
	sdkmanager --uninstall --package_file=.tmp_android_remove
	sdkmanager --list_installed --include_obsolete | grep '^  [a-z]' | sort | uniq > $@

softwareupdate-history.txt:
	softwareupdate -ia
	softwareupdate --history > $@

pip.lock: requirements.txt
	pip install -r $^
	pip freeze --all > $@

