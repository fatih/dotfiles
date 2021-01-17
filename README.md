dotfiles
========

My personal dotfiles. 

Please only open pull requests that fix bugs or adds improvements without any
breaking changes.

These dotfiles are very personal, and I know that everyone has a different
taste; hence fork this repository or copy/paste them into your own `dotfiles`
repo.

# On a new machine

```
# install all brew dependencies
brew bundle

# copy dotfiles to the appropriate places
make

# make zsh the new default
chsh -s /bin/zsh

# setup vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# open vim and install all plugins
:PLugInstall

# install tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# disable font smoothing
defaults -currentHost write -g AppleFontSmoothing -int 0
```
