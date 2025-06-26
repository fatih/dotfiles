# Halcyon Elora's Default Keymap

## Setup:

```
# git clone forked qmk_userspace
cd ~/Code
git clone git@github.com:fatih/qmk_userspace.git

# edit keymap
vim qmk_userspace/keyboards/splitkb/halcyon/elora/keymaps/fatih/keymap.c

# FW is compiled via GH actions
git add/commit/push

# Download FW:
https://github.com/fatih/qmk_userspace/releases/tag/latest
```

## Flash the keyboard:

* Either enter `QK_BOOT` or double press the reset button on each half.
* Upload the specific FW to the bootloader (drag and drop to mounted device). 
* Do it for each side.
