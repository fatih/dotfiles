FROM debian:sid

RUN apt-get update && apt-get -qy upgrade
RUN apt-get -qy install \
    build-essential apt-transport-https ca-certificates curl gnupg2 \ 
    software-properties-common locales tzdata ispell mysql-client \
    libssl-dev libreadline-dev zlib1g-dev libffi-dev \
    wget mosh vim tmux zsh curl git jq direnv unzip htop dnsutils tig

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
RUN wget https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb
RUN sudo dpkg -i jump_0.22.0_amd64.deb

RUN wget https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.11.2.linux-amd64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

# RUN zsh -c "go get -u golang.org/x/tools/cmd/..."
# RUN zsh -c "go get -u github.com/aybabtme/humanlog/cmd/..."

RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions


COPY . /root

RUN ln -s /root/vimrc ~/.vimrc
RUN ln -s /root/zshrc ~/.zshrc
RUN ln -s /root/tmuxconf ~/.tmux.conf
RUN ln -s /root/tigrc ~/.tigrc
RUN ln -s /root/git-prompt.sh ~/.git-prompt.sh
RUN ln -s /root/gitconfig ~/.gitconfig
RUN ln -s /root/agignore ~/.agignore



WORKDIR /root

# COPY session-init.sh /bin/session-init
CMD ["/usr/bin/zsh","-l"]


