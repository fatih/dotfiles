#!/bin/bash

set -eu

apt-get update
apt-get upgrade -y

# get rid of "exiting sent invalidate(group) request, exiting" issues
# https://www.digitalocean.com/community/questions/debian-9-3-droplet-issues-with-useradd
apt-get remove unscd -y

apt-get install -qq -y \
	apache2-utils \
	apt-transport-https \
	build-essential \
	bzr \
	ca-certificates \
	clang \
	cmake \
	curl \
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
	openssh-server \
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
	silversearcher-ag \
	shellcheck \
	socat \
	sqlite3 \
	stow \
	sudo \
	tig \
	tmate \
	tree \
	unzip \
	vim-nox \
	wget \
	zgen \
	zip \
	zlib1g-dev \
	zsh \
  gnupg2 \
  libvirt-clients \
  libvirt-daemon-system \
  qemu-kvm \
  software-properties-common \
	--no-install-recommends


chsh -s /usr/bin/zsh

# enable backports to install latest tmux
add-apt-repository "deb http://mirrors.digitalocean.com/debian stretch-backports main contrib non-free" -s
apt-get update && apt-get install -y -t stretch-backports tmux

# install docker
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update && apt-get install -qy docker-ce

echo "Configure custom ip block for docker..."
echo '{"bip":"172.24.0.1/24","fixed-cidr":"172.24.0.0/24"}' > /etc/docker/daemon.json
systemctl restart docker

echo "Installing fzf"
git clone https://github.com/junegunn/fzf /root/.fzf
cd /root/.fzf && git remote set-url origin git@github.com:junegunn/fzf.git
/root/.fzf/install --bin --64 --no-bash --no-zsh --no-fish

echo "Installing kubectl"
curl -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod 755 /usr/local/bin/kubectl

echo "Configure routes to preserve networking for vpn..."
ip=$(ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
subnet=$(ip route | grep -Po '^\d+(.\d+){3}/\d+(?= dev eth0)')
gateway=$(ip route | grep -Po '(?<=default via )[.\d]+')
ip rule add from $ip table 128 > /dev/null 2>&1 || true
ip route add table 128 to $subnet dev eth0 > /dev/null 2>&1 || true
ip route add table 128 default via $gateway > /dev/null 2>&1 || true

echo "128	mgmt" > /etc/iproute2/rt_tables.d/mgmt.conf
grep -q '# routing rules for vpn' /etc/network/interfaces || {
    echo "	# routing rules for vpn" >> /etc/network/interfaces
    echo "	post-up ip rule add from $ip table 128" >> /etc/network/interfaces
    echo "	post-up ip route add table 128 to $subnet dev eth0" >> /etc/network/interfaces
    echo "	post-up ip route add table 128 default via $gateway" >> /etc/network/interfaces
}

echo "Installing vpn..."
mkdir vpn && cd vpn
curl -Lo vpn.tgz https://security.nyc3.digitaloceanspaces.com/VPN/PanGPLinux-4.1.6-c3.tgz
tar -zxvf vpn.tgz
apt-get install -qy ./GlobalProtect_deb-4.1.6.0-3.deb
rm -rf vpn
cd ../
# workaround for vpn cert issue
mkdir -p /home/yyin/opensource/openssl/openssl-1.0.1t-build/ssl/certs
ln -s /etc/ssl/certs/3513523f.0 /home/yyin/opensource/openssl/openssl-1.0.1t-build/ssl/certs/. > /dev/null 2>&1

# install 1password
curl -sS -o 1password.zip https://cache.agilebits.com/dist/1P/op/pkg/v0.5.4/op_linux_amd64_v0.5.4.zip && unzip 1password.zip op -d /usr/local/bin && rm 1password.zip

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

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions

mkdir /home/fatih/code/
cd /home/fatih/code

# tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tmux-open.git ~/.tmux/plugins/tmux-open
git clone https://github.com/tmux-plugins/tmux-prefix-highlight.git ~/.tmux/plugins/tmux-prefix-highlight

git clone --recursive https://github.com/fatih/dotfiles.git  && cd dotfiles

ln -s \$(pwd)/vimrc /home/fatih/.vimrc
ln -s \$(pwd)/zshrc /home/fatih/.zshrc
ln -s \$(pwd)/tmuxconf /home/fatih/.tmux.conf
ln -s \$(pwd)/tigrc /home/fatih/.tigrc
ln -s \$(pwd)/git-prompt.sh /home/fatih/.git-prompt.sh
ln -s \$(pwd)/gitconfig /home/fatih/.gitconfig
ln -s \$(pwd)/agignore /home/fatih/.agignore
EOF

echo "Done!"
