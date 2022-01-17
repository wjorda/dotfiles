.DEFAULT_GOAL := default

Brewfile.lock.json: Brewfile
	brew bundle --cleanup
packages: Brewfile.lock.json


SYMLINKS:=\
	~/.config/fish/config.fish\
	~/.gitconfig\
  ~/.bashrc

~/config/fish/config.fish: config.fish
	mkdir -p ~/.config/fish
	ln -sf $(PWD)/$^ $@

~/.gitconfig: .gitconfig
	ln -sf $(PWD)/$^ $@

~/.bashrc: .bashrc
	ln -sf $(PWD)/$^ $@

symlinks: $(SYMLINKS)


/Library/Java/JavaVirtualMachines/openjdk.jdk: /usr/local/opt/openjdk/libexec/openjdk.jdk
	sudo ln -sfn $^ $@
java: /Library/Java/JavaVirtualMachines/openjdk.jdk 


android-lock.txt: android-requirements.txt
	sdkmanager --package_file=$^
	sdkmanager --list_installed --include_obsolete > $@
android: android-lock.txt


softwareupdate-history.txt:
	softwareupdate -ia
	softwareupdate --history > $@
system: softwareupdate-history.txt


pip.lock: requirements.txt
	pip3 install -r $^
	pip3 freeze --all > $@
python: pip.lock


update: packages symlinks java android python

clean:
	rm -rf softwareupdate-history.txt
	rm -rf android-lock.txt
	rm -rf Brewfile.lock.json
	rm -rf pip.lock

upgrade: clean system update

default: update
