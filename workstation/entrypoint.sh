#!/bin/bash

set -e

if [ ! -d ~/code/dotfiles ]; then
  echo "Cloning dotfiles"
  # the reason we dont't copy the files individually is, to easily push changes
  # if needed
  cd ~/code
  git clone --recursive https://github.com/fatih/dotfiles.git
  cd dotfiles 
  git remote set-url origin git@github.com:fatih/dotfiles.git
  
  ln -s $(pwd)/vimrc ~/.vimrc
  ln -s $(pwd)/zshrc ~/.zshrc
  ln -s $(pwd)/tmuxconf ~/.tmux.conf
  ln -s $(pwd)/tigrc ~/.tigrc
  ln -s $(pwd)/git-prompt.sh ~/.git-prompt.sh
  ln -s $(pwd)/gitconfig ~/.gitconfig
  ln -s $(pwd)/agignore ~/.agignore
  ln -s $(pwd)/sshconfig ~/.ssh/config
fi


/usr/sbin/sshd -D

