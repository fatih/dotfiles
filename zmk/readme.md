Glove80 FW can be compiled directly from the MoErgo's online layout editor: [my.glove80.com](https://my.glove80.com).

My most recent layout can be seen here: https://my.glove80.com/#/layout/user/e00fadad-ac46-4657-b3bc-47b5a41308cf

I occasionaly make a backup of the ZMK keymap (see `zmk/glove80.keymap`) to my dotfiles repo, in case I
lose access to the layout editor in the future.

# Loading FW from my.glove80.com to the keyboard 

1. Hit `Save and Build firmware`. A file with `.uf2` will be downloaded.
2. Plug first **right** half via USB-C. Hit `magic + '`. Upload the FW to the bootloader disk. It will automatically eject.
3. Plug **left** half via USB-C. Hit `magic + ctrl`. Upload the FW to the bootloader disk. It will automatically eject.
4. Done.
