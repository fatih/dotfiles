#!/bin/bash

set -eu

# run this after creating the user on the host
# 1. adduser fatih
# 2. usermod -aG sudo fatih
# 3. su - fatih


# install vim plugins
mkdir -p /home/fatih/.vim/plugged && cd /home/fatih/.vim/plugged
git clone 'https://github.com/AndrewRadev/splitjoin.vim'
git clone 'https://github.com/ConradIrwin/vim-bracketed-paste'
git clone 'https://github.com/Raimondi/delimitMate'
git clone 'https://github.com/SirVer/ultisnips'
git clone 'https://github.com/cespare/vim-toml'
git clone 'https://github.com/corylanou/vim-present'
git clone 'https://github.com/ekalinin/Dockerfile.vim'
git clone 'https://github.com/elzr/vim-json'
git clone 'https://github.com/fatih/vim-go'
git clone 'https://github.com/fatih/vim-hclfmt'
git clone 'https://github.com/fatih/vim-nginx'
git clone 'https://github.com/godlygeek/tabular'
git clone 'https://github.com/hashivim/vim-hashicorp-tools'
git clone 'https://github.com/junegunn/fzf.vim'
git clone 'https://github.com/mileszs/ack.vim'
git clone 'https://github.com/plasticboy/vim-markdown'
git clone 'https://github.com/scrooloose/nerdtree'
git clone 'https://github.com/t9md/vim-choosewin'
git clone 'https://github.com/tmux-plugins/vim-tmux'
git clone 'https://github.com/fatih/molokai'
git clone 'https://github.com/tpope/vim-commentary'
git clone 'https://github.com/tpope/vim-eunuch'
git clone 'https://github.com/tpope/vim-fugitive'
git clone 'https://github.com/tpope/vim-repeat'
git clone 'https://github.com/tpope/vim-scriptease'
git clone 'https://github.com/ervandew/supertab'

# user setup
mkdir ~/.ssh && curl -fsL https://github.com/fatih.keys > ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions

mkdir /home/fatih/code/
cd /home/fatih/code

git clone --recursive https://github.com/fatih/dotfiles.git  && cd dotfiles
#TODO(arslan): remove this
git checkout dockerize

ln -s $(pwd)/vimrc /home/fatih/.vimrc
ln -s $(pwd)/zshrc /home/fatih/.zshrc
ln -s $(pwd)/tmuxconf /home/fatih/.tmux.conf
ln -s $(pwd)/tigrc /home/fatih/.tigrc
ln -s $(pwd)/git-prompt.sh /home/fatih/.git-prompt.sh
ln -s $(pwd)/gitconfig /home/fatih/.gitconfig
ln -s $(pwd)/agignore /home/fatih/.agignore

sudo chsh -s /usr/bin/zsh

echo "Done!"
