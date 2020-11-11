dotfiles
========

My personal dotfiles

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
```
