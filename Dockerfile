ARG GOLANG_VERSION=1.11.4

# install kubectl
FROM ubuntu:18.10 as kubectl_builder
RUN apt-get update && apt-get install -y curl ca-certificates
RUN curl -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod 755 /usr/local/bin/kubectl

# install 1password
FROM ubuntu:18.10 as onepassword_builder
RUN apt-get update && apt-get install -y curl ca-certificates unzip
RUN curl -sS -o 1password.zip https://cache.agilebits.com/dist/1P/op/pkg/v0.5.4/op_linux_amd64_v0.5.4.zip && unzip 1password.zip op -d /usr/bin &&  rm 1password.zip

# install vim plugins
FROM ubuntu:18.10 as vim_plugins_builder
RUN apt-get update && apt-get install -y git ca-certificates
RUN mkdir -p /root/.vim/plugged && cd /root/.vim/plugged && \ 
	git clone 'https://github.com/AndrewRadev/splitjoin.vim' && \ 
	git clone 'https://github.com/ConradIrwin/vim-bracketed-paste' && \
	git clone 'https://github.com/Raimondi/delimitMate' && \
	git clone 'https://github.com/SirVer/ultisnips' && \
	git clone 'https://github.com/cespare/vim-toml' && \
	git clone 'https://github.com/corylanou/vim-present' && \
	git clone 'https://github.com/ekalinin/Dockerfile.vim' && \
	git clone 'https://github.com/elzr/vim-json' && \
	git clone 'https://github.com/fatih/vim-go' && \
	git clone 'https://github.com/fatih/vim-hclfmt' && \
	git clone 'https://github.com/fatih/vim-nginx' && \
	git clone 'https://github.com/godlygeek/tabular' && \
	git clone 'https://github.com/hashivim/vim-hashicorp-tools' && \
	git clone 'https://github.com/junegunn/fzf.vim' && \
	git clone 'https://github.com/mileszs/ack.vim' && \
	git clone 'https://github.com/roxma/vim-tmux-clipboard' && \
	git clone 'https://github.com/plasticboy/vim-markdown' && \
	git clone 'https://github.com/scrooloose/nerdtree' && \
	git clone 'https://github.com/t9md/vim-choosewin' && \
	git clone 'https://github.com/tmux-plugins/vim-tmux' && \
	git clone 'https://github.com/fatih/molokai' && \
	git clone 'https://github.com/tpope/vim-commentary' && \
	git clone 'https://github.com/tpope/vim-eunuch' && \
	git clone 'https://github.com/tpope/vim-fugitive' && \
	git clone 'https://github.com/tpope/vim-repeat' && \
	git clone 'https://github.com/tpope/vim-scriptease' && \
	git clone 'https://github.com/ervandew/supertab'

# install go tools
FROM golang:$GOLANG_VERSION as golang_builder
RUN go get -u github.com/davidrjenni/reftools/cmd/fillstruct
RUN go get -u github.com/mdempsky/gocode
RUN go get -u github.com/rogpeppe/godef
RUN go get -u github.com/zmb3/gogetdoc
RUN go get -u golang.org/x/tools/cmd/goimports
RUN go get -u github.com/golang/lint/golint
RUN go get -u github.com/alecthomas/gometalinter
RUN go get -u github.com/fatih/gomodifytags
RUN go get -u golang.org/x/tools/cmd/gorename
RUN go get -u golang.org/x/tools/cmd/guru
RUN go get -u github.com/josharian/impl
RUN go get -u honnef.co/go/tools/cmd/keyify
RUN go get -u github.com/fatih/motion
RUN go get -u github.com/koron/iferr

# generic tools
RUN go get -u github.com/aybabtme/humanlog/cmd/...

# base OS
FROM ubuntu:18.10
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get upgrade -y && apt-get install -qq -y \
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
	docker.io \
	fakeroot-ng \
	gdb \
	git \
	git-crypt \
	gnupg \
	gnupg2 \
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
	libvirt-clients \
	libvirt-daemon-system \
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
	qemu-kvm \
	qrencode \
	quilt \
	ripgrep \
	shellcheck \
	silversearcher-ag \
	socat \
	software-properties-common \
	sqlite3 \
	stow \
	sudo \
	tig \
	tmate \
	tmux \
	tree \
	unzip \
	wget \
	zgen \
	zip \
	zlib1g-dev \
	zsh \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*


RUN mkdir /run/sshd
RUN add-apt-repository ppa:jonathonf/vim -y && apt-get update && apt-get install vim-gtk3 -y

RUN wget https://dl.google.com/go/go1.11.4.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.11.4.linux-amd64.tar.gz && rm go1.11.4.linux-amd64.tar.gz

ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
	locale-gen --purge $LANG && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG=$LANG LC_ALL=$LC_ALL LANGUAGE=$LANGUAGE

# gcloud
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
  echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
  apt-get update -y && apt-get install google-cloud-sdk google-cloud-sdk-app-engine-go -y

RUN wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy && chmod +x cloud_sql_proxy &&  cp cloud_sql_proxy /usr/local/bin

# doctl
RUN wget https://github.com/digitalocean/doctl/releases/download/v1.12.2/doctl-1.12.2-linux-amd64.tar.gz && tar xf doctl-1.12.2-linux-amd64.tar.gz && chmod +x doctl && mv doctl /usr/local/bin && rm doctl-1.12.2-linux-amd64.tar.gz

# for correct colours is tmux
ENV TERM screen-256color

# kubectl
COPY --from=kubectl_builder /usr/local/bin/kubectl /usr/local/bin/

# kubectl
COPY --from=onepassword_builder /usr/bin/op /usr/local/bin/

# golang tools
COPY --from=golang_builder /go/bin/* /usr/local/bin/

# install tools
RUN wget https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb && sudo dpkg -i jump_0.22.0_amd64.deb && rm -rf jump_0.22.0_amd64.deb

# user setup
ARG user=fatih
ARG uid=1001
ARG github_user=fatih
RUN useradd -m $user -u $uid -G users,sudo,docker -s /bin/zsh
# RUN echo "fatih:Docker!" | sudo chpasswd # only enable if you need testing
USER $user

RUN mkdir ~/.ssh && curl -fsL https://github.com/$github_user.keys > ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# vim plugins
COPY --from=vim_plugins_builder /root/.vim/plugged /home/fatih/.vim/plugged

RUN git clone https://github.com/junegunn/fzf /home/fatih/.fzf && cd /home/fatih/.fzf && git remote set-url origin git@github.com:junegunn/fzf.git && /home/fatih/.fzf/install --bin --64 --no-bash --no-zsh --no-fish

# zsh plugins
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# tmux plugins
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
RUN git clone https://github.com/tmux-plugins/tmux-open.git ~/.tmux/plugins/tmux-open
RUN git clone https://github.com/tmux-plugins/tmux-yank.git ~/.tmux/plugins/tmux-yank
RUN git clone https://github.com/tmux-plugins/tmux-prefix-highlight.git ~/.tmux/plugins/tmux-prefix-highlight

# the reason we dont't copy the files individually is, to easily push changes if needed
RUN git clone --recursive https://github.com/fatih/dotfiles.git /home/fatih/code/dotfiles

RUN ln -s /home/fatih/code/dotfiles/vimrc /home/fatih/.vimrc
RUN ln -s /home/fatih/code/dotfiles/zshrc /home/fatih/.zshrc
RUN ln -s /home/fatih/code/dotfiles/tmuxconf /home/fatih/.tmux.conf
RUN ln -s /home/fatih/code/dotfiles/tigrc /home/fatih/.tigrc
RUN ln -s /home/fatih/code/dotfiles/git-prompt.sh /home/fatih/.git-prompt.sh
RUN ln -s /home/fatih/code/dotfiles/gitconfig /home/fatih/.gitconfig
RUN ln -s /home/fatih/code/dotfiles/agignore /home/fatih/.agignore
RUN ln -s /home/fatih/code/dotfiles/sshconfig /home/fatih/.ssh/config

WORKDIR /home/fatih
CMD ["/usr/bin/tmux"]
