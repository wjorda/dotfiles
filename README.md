Mac Dotfiles and System Configuration.

Requirements:
- Mac running OS 11 or newer.
- A working Homebrew installation.
- XCode utilities installed.

To install everything:
```
make
```

To reconcile state:
```
make update
```
This will only do things if the Brewfile and android-requirements.txt files are newer than the lockfiles.

To blow away lockfiles and upgrade everything:
```
make upgrade
```
