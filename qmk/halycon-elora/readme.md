# Halcyon Elora's Default Keymap

Setup:

```
# Install QMK if not yet installed
brew install qmk/qmk/qmk

# Clone qmk repository with 
qmk setup

# git clone qmk_userspace
cd ~/Code
git clone git@github.com:splitkb/qmk_userspace.git
qmk config user.overlay_dir="$(realpath qmk_userspace)"

# link keymap into the qmk folder
ln -s ~/Code/dotfiles/qmk/halycon-elora/ ~/Code/qmk_userspace/keyboards/splitkb/halcyon/elora/keymaps/fatih

# compile the firmware
```

