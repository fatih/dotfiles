ARG GOLANG_VERSION=1.11.4

# install kubectl
FROM debian:buster as kubectl_builder
RUN apt-get update && apt-get install -y curl ca-certificates unzip
RUN curl -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod 755 /usr/local/bin/kubectl

# install 1password
FROM debian:buster as onepassword_builder
RUN apt-get update && apt-get install -y curl ca-certificates unzip
RUN curl -sS -o 1password.zip https://cache.agilebits.com/dist/1P/op/pkg/v0.5.4/op_linux_amd64_v0.5.4.zip && unzip 1password.zip op -d /usr/bin &&  rm 1password.zip

# install vim plugins
FROM debian:buster as vim_plugins_builder
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
FROM debian:buster
RUN apt-get update -qq && apt-get upgrade -y && apt-get install -qq -y \
	apache2-utils \
	apt-transport-https \
	build-essential \
	ca-certificates \
	clang \
	cmake \
	curl \
	default-libmysqlclient-dev \
	default-mysql-client \
	direnv \
	dnsutils \
	docker-compose \
	docker.io \
	fakeroot-ng \
	fzf \
	gdb \
	git \
	git-crypt \
	gnupg \
	golang-1.11 \
	htop \
	hub \
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
	ripgrep \
	shellcheck \
	socat \
	sqlite3 \
	stow \
	sudo \
	tig \
	tmate \
	tmux \
	tree \
	unzip \
	vim-nox \
	wget \
	zgen \
	zip \
	zlib1g-dev \
	zsh \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed 's/#Port 22/Port 3222/' -i /etc/ssh/sshd_config

ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
	locale-gen --purge $LANG && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG=$LANG LC_ALL=$LC_ALL LANGUAGE=$LANGUAGE

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

# go
RUN wget https://dl.google.com/go/go1.11.4.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.11.4.linux-amd64.tar.gz && rm go1.11.4.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"

# user setup
ARG user=fatih
ARG uid=1000
ARG github_user=fatih
RUN useradd -m $user -u $uid -G users,sudo,docker -s /bin/zsh
# RUN echo "fatih:Docker!" | sudo chpasswd # only enable if you need testing
USER $user
RUN mkdir ~/.ssh && curl -fsL https://github.com/$github_user.keys > ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# vim plugins
COPY --from=vim_plugins_builder /root/.vim/plugged /home/fatih/.vim/

# zsh plugins
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

COPY vimrc /home/fatih/.vimrc
COPY zshrc /home/fatih/.zshrc
COPY tmuxconf /home/fatih/.tmux.conf
COPY tigrc /home/fatih/.tigrc
COPY git-prompt.sh /home/fatih/.git-prompt.sh
COPY gitconfig /home/fatih/.gitconfig
COPY agignore /home/fatih/.agignore

ENV PATH="/usr/local/go/bin:${PATH}"

# make sure we start sshd at the end - always keep this at the bottom
USER root
EXPOSE 3222 63200-63220/udp
CMD ["/usr/sbin/sshd", "-D"]
