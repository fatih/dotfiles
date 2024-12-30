# My custom keymap for the Mode Encore Series 2

Setup:


```
# Install QMK if not yet installed
brew install qmk/qmk/qmk

# Clone qmk repository with 
qmk setup

# link keymap into the qmk folder
ln -s ~/Code/dotfiles/qmk/mode-encore/ ~/qmk_firmware/keyboards/mode/m256wh/keymaps/fatih

# compile the firmware
qmk compile -kb mode/m256wh -km fatih

# flash the layout with our layout
use qmk-toolbox
```

Notes:


* Vial support for Mode keyboards: https://github.com/vial-kb/vial-qmk/tree/vial/keyboards/mode/m256wh (H stands for HotSwap, S stands for Soldered)

* Install `qmk toolbox` via Brew Cask:

```
brew install qmk-toolbox
```

