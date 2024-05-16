# My custom keymap for the Kinesis

Setup:


```
# Install QMK if not yet installed
brew install qmk/qmk/qmk

# Clone qmk repository with 
qmk setup -b develop

# copy the custom keymaps into the keymaps folder
cd ~/qmk_firmware/
cp -r ~/Code/dotfiles/qmk/ keyboards/kinesis/keymaps/fatih

# compile the firmware
qmk compile -kb kinesis/kint41 -km fatih

# flash the layout with our layout
teensy_loader_cli -w -v  --mcu=TEENSY41 .build/kinesis_kint41_fatih.hex

```

Notes:

* There is no support for Teensy 4.1 in master branch of QMK. You have to use `develop` branch.

* Install `teensy_loader_cli` from head, because the default version in brew doesn't support Teensy 4.1:

```
brew install --HEAD teensy_loader_cli
```

Verify that `4.1` is supported with: 

```
$ teensy_loader_cli --list-mcus
Supported MCUs are:
 - at90usb162
 - atmega32u4
 - at90usb646
 - at90usb1286
 - mkl26z64
 - mk20dx128
 - mk20dx256
 - mk66fx1m0
 - mk64fx512
 - imxrt1062
 - TEENSY2
 - TEENSY2PP
 - TEENSYLC
 - TEENSY30
 - TEENSY31
 - TEENSY32
 - TEENSY35
 - TEENSY36
 - TEENSY40
 - TEENSY41
```

You should see `TEENSY41` in the list.
