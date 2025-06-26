dotfiles
========

My personal dotfiles. 

Please only open pull requests that fix bugs or adds improvements without any
breaking changes. These dotfiles are very personal, and I know that everyone
has a different taste; hence fork this repository or copy/paste them into your
own `dotfiles` repo. I might refuse PR's if they change my workflow
significantly.

# On a new machine

```
# copy dotfiles to the appropriate places
make

# make fish the new default
chsh -s /usr/local/bin/fish

# generate and add new SSH key
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

# open Nvim. Lazy.nvim will automatically install all plugins
vim

# disable font smoothing
defaults -currentHost write -g AppleFontSmoothing -int 0
```

## Keyboards

# Configuring Kinesis Advantage 360 Pro

Follow instructions in https://github.com/fatih/Adv360-Pro-ZMK

# Configuring MoErgo Glove80 Keyboard

See `zmk/readme.md`

# Configuring Kinesis Advantage2 Keyboard

See `qmk/advantage-2/readme.md`

# Configuring Mode Encore Series

See `qmk/mode-encore/readme.md`

# Configuring Halcyon Elora

See `qmk/halcyon-elora/readme.md`
