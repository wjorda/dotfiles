.DEFAULT_GOAL := default

Brewfile.lock.json: Brewfile
	brew bundle --cleanup
packages: Brewfile.lock.json

symlinks:
	ln -sf $(PWD)/config.fish ~/.config/fish/config.fish
	ln -sf $(PWD)/.gitconfig ~/.gitconfig
	ln -sf $(PWD)/.bashrc ~/.bashrc

/Library/Java/JavaVirtualMachines/openjdk.jdk: /usr/local/opt/openjdk/libexec/openjdk.jdk
	sudo ln -sfn $^ $@
java: /Library/Java/JavaVirtualMachines/openjdk.jdk 

android-lock.txt: android-requirements.txt
	sdkmanager --package_file=$^
	sdkmanager --list_installed --include_obsolete > $@
android: android-lock.txt

update: packages symlinks java android

clean:
	rm -rf android-lock.txt
	rm -rf Brewfile.lock.json

upgrade: clean update

default: update
