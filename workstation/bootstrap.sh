#!/bin/bash

set -eu

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y

apt-get install -qq -y --force-yes \
	apache2-utils \
	apt-transport-https \
	build-essential \
	bzr \
	ca-certificates \
	clang \
	cmake \
	curl \
  docker.io \
	default-libmysqlclient-dev \
	default-mysql-client \
	direnv \
	dnsutils \
	fakeroot-ng \
	gdb \
	git \
	git-crypt \
	gnupg \
	htop \
	hugo \
	ipcalc \
	jq \
	less \
	libclang-dev \
	liblzma-dev \
	libpq-dev \
	libprotoc-dev \
	libsqlite3-dev \
	libssl-dev \
	lldb \
	locales \
	man \
	mosh \
	mtr-tiny \
	musl-tools \
	ncdu \
	netcat-openbsd \
	pkg-config \
	protobuf-compiler \
	pwgen \
	python \
	python3 \
	python3-flake8 \
	python3-pip \
	python3-setuptools \
	python3-venv \
	python3-wheel \
	qrencode \
	quilt \
	shellcheck \
	silversearcher-ag \
	socat \
	sqlite3 \
	stow \
	sudo \
	tig \
	tmate \
	tree \
	unzip \
	wget \
	xsel \
	xclip \
	zgen \
	zip \
	zlib1g-dev \
	zsh \
  neovim \
  gnupg2 \
  libvirt-clients \
  libvirt-daemon-system \
  qemu-kvm \
  software-properties-common \
	--no-install-recommends

chsh -s /usr/bin/zsh


echo "Installing vim"
# install latest vim with clipboard and python support
add-apt-repository ppa:jonathonf/vim -y
apt-get update
apt-get install vim-gtk3 -y

echo "Installing kubectl"
curl -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod 755 /usr/local/bin/kubectl

echo "Installing 1password"
curl -sS -o 1password.zip https://cache.agilebits.com/dist/1P/op/pkg/v0.5.4/op_linux_amd64_v0.5.4.zip && unzip 1password.zip op -d /usr/local/bin && rm 1password.zip

echo "Installing Go"
export GOLANG_VERSION="1.11.4"
export PATH="/usr/local/go/bin:${PATH}"
export GOBIN="/usr/local/bin"

wget https://dl.google.com/go/go${GOLANG_VERSION}.linux-amd64.tar.gz && tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz && rm go${GOLANG_VERSION}.linux-amd64.tar.gz

export GO111MODULE=off

# install go tools
go get -u github.com/davidrjenni/reftools/cmd/fillstruct
go get -u github.com/mdempsky/gocode
go get -u github.com/rogpeppe/godef
go get -u github.com/zmb3/gogetdoc
go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/golang/lint/golint
go get -u github.com/fatih/gomodifytags
go get -u golang.org/x/tools/cmd/gorename
go get -u golang.org/x/tools/cmd/guru
go get -u github.com/josharian/impl
go get -u honnef.co/go/tools/cmd/keyify
go get -u github.com/fatih/motion
go get -u github.com/koron/iferr

# generic tools
go get -u github.com/aybabtme/humanlog/cmd/...

# remove the default go directory after installing all binaries
rm -rf /root/go

# install tools
wget https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb && sudo dpkg -i jump_0.22.0_amd64.deb && rm -rf jump_0.22.0_amd64.deb

# install doctl
wget https://github.com/digitalocean/doctl/releases/download/v1.12.2/doctl-1.12.2-linux-amd64.tar.gz
tar xf ~/doctl-1.12.2-linux-amd64.tar.gz
chmod +x doctl
mv doctl /usr/local/bin

# install gcloud
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk google-cloud-sdk-app-engine-go

# install cloud_sql_proxy
wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
chmod +x cloud_sql_proxy
cp cloud_sql_proxy /usr/local/bin

# create our user
useradd -m fatih -u 1001 -G users,sudo,docker -s /bin/zsh

# continue installing specific things as user
sudo -u fatih bash << EOF
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

# fzf
git clone https://github.com/junegunn/fzf /home/fatih/.fzf
cd /home/fatih/.fzf && git remote set-url origin git@github.com:junegunn/fzf.git
/home/fatih/.fzf/install --bin --64 --no-bash --no-zsh --no-fish

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# in case I want to use neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions

mkdir /home/fatih/code/ && cd /home/fatih/code

# tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tmux-open.git ~/.tmux/plugins/tmux-open
git clone https://github.com/tmux-plugins/tmux-yank.git ~/.tmux/plugins/tmux-yank
git clone https://github.com/tmux-plugins/tmux-prefix-highlight.git ~/.tmux/plugins/tmux-prefix-highlight

git clone --recursive https://github.com/fatih/dotfiles.git  && cd dotfiles

ln -s \$(pwd)/vimrc /home/fatih/.vimrc
ln -s \$(pwd)/vimrc /home/faith/.config/nvim/init.vim
ln -s \$(pwd)/zshrc /home/fatih/.zshrc
ln -s \$(pwd)/tmuxconf /home/fatih/.tmux.conf
ln -s \$(pwd)/tigrc /home/fatih/.tigrc
ln -s \$(pwd)/git-prompt.sh /home/fatih/.git-prompt.sh
ln -s \$(pwd)/gitconfig /home/fatih/.gitconfig
ln -s \$(pwd)/agignore /home/fatih/.agignore
ln -s \$(pwd)/sshconfig /home/fatih/.ssh/config
EOF

echo "Done!"
