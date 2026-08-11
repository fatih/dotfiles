# My custom keymap for the Kyria Halcyon

Setup:


```
# Install QMK if not yet installed
brew install qmk/qmk/qmk

# Clone qmk repository with 
qmk setup

# Clone qmk user repository repository with 
cd ~/Code
git clone git@github.com:fatih/qmk_userspace.git

# Add userspace to the config
qmk config user.overlay_dir="$(realpath qmk_userspace)"

# Add userspace configs for each target
qmk userspace-add -kb splitkb/halcyon/kyria/rev4 -km fatih -e HLC_TFT_DISPLAY=1 -e TARGET=splitkb_halcyon_kyria_rev4_default_hlc_display
qmk userspace-add -kb splitkb/halcyon/kyria/rev4 -km fatih -e HLC_ENCODER=1 -e TARGET=splitkb_halcyon_kyria_rev4_default_hlc_encoder

# link keymap into the qmk folder
ln -s ~/Code/dotfiles/qmk/kyria/ ~/qmk_firmware/keyboards/splitkb/halcyon/kyria/keymaps/fatih

# compile the firmware, for left with display, for right with the encoder
# this is for verification, we only need do it once, we'll use qmk flash later
qmk compile -kb splitkb/halcyon/kyria/rev4 -km fatih -e HLC_TFT_DISPLAY=1 -e TARGET=splitkb_halcyon_kyria_rev4_default_hlc_display
qmk compile -kb splitkb/halcyon/kyria/rev4 -km fatih -e HLC_ENCODER=1 -e TARGET=splitkb_halcyon_kyria_rev4_default_hlc_encoder

# flash the layout with our layout
qmk flash -kb splitkb/halcyon/kyria/rev4 -km fatih -e HLC_TFT_DISPLAY=1 -e TARGET=splitkb_halcyon_kyria_rev4_default_hlc_display
qmk flash -kb splitkb/halcyon/kyria/rev4 -km fatih -e HLC_ENCODER=1 -e TARGET=splitkb_halcyon_kyria_rev4_default_hlc_encoder
```

Notes:

To flash each side:

1. Plug first left side
2. Run the `qmk flash` command above with the `display` option
3. Press reset button twice (next to the host USB-C input)

4. Plug the right side
5. Run the `qmk flash` command above with the `encoder` option

