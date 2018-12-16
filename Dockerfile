FROM debian:sid

RUN apt-get update && apt-get -qy upgrade && apt-get -qy install \
    build-essential apt-transport-https ca-certificates curl gnupg2 \ 
    software-properties-common locales tzdata ispell mysql-client \
    libssl-dev libreadline-dev zlib1g-dev libffi-dev \
    wget mosh vim-nox tmux zsh curl git jq direnv unzip htop dnsutils tig

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen en_US.UTF-8 
ENV LANG=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# for correct colours is tmux
ENV TERM screen-256color

# use buster because no repo exists for sid
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add

RUN apt-get update && apt-get -y install docker-ce

RUN chsh -s /usr/bin/zsh

RUN curl -sLO https://storage.googleapis.com/kubernetes-release/release/v1.12.2/bin/linux/amd64/kubectl && chmod +x kubectl && mv kubectl /usr/local/bin/kubectl

RUN git clone https://github.com/junegunn/fzf /root/.fzf
RUN cd /root/.fzf && git remote set-url origin git@github.com:junegunn/fzf.git
RUN /root/.fzf/install --bin --64 --no-bash --no-zsh --no-fish

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


# vim plugins
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

# install tools
RUN wget https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb && sudo dpkg -i jump_0.22.0_amd64.deb

# go
RUN wget https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.11.2.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"

# zsh plugins
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# vim-go tools
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

RUN cp /root/go/bin/* /usr/local/bin/ && rm -rf /root/go

COPY vimrc /root/.vimrc
COPY zshrc /root/.zshrc
COPY tmuxconf /root/.tmux.conf
COPY tigrc /root/.tigrc
COPY git-prompt.sh /root/.git-prompt.sh
COPY gitconfig /root/.gitconfig
COPY agignore /root/.agignore

WORKDIR /root

CMD ["zsh", "-c", "/usr/bin/tmux attach || /usr/bin/tmux new"]


