FROM ubuntu:16.04

MAINTAINER Loric Brevet <loric.brevet@gmail.com>

# Install usefull tools
RUN apt-get update \
  && apt-get install -y \
  sudo \
  man-db \
  curl \
  wget \
  netcat \
  traceroute \
  iputils-ping \
  openvpn \
  htop \
  jq \
  zsh \
  vim \
  git \
  tmux \
  ranger \
  ssh \
  python \
  python-pip \
  python3 \
  python3-pip \
  ansible \
  autojump \
  tree \
  httpie \
  acpi \
  ack-grep \
  silversearcher-ag \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install golang
RUN wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz \
    && tar -xvf go1.10.3.linux-amd64.tar.gz \
    && mv go /usr/local

# Install python packages
RUN pip install \
  speedtest-cli

RUN pip3 install \
  bpython \
  ipython

# Install sshrc
RUN wget https://raw.githubusercontent.com/Russell91/sshrc/master/sshrc \
  && chmod +x sshrc \
  && sudo mv sshrc /usr/local/bin

# Create user
ENV HOME /home/dev
RUN useradd --create-home --home-dir $HOME dev \
  && chown -R dev:dev $HOME
RUN echo "dev:dev" | chpasswd
RUN usermod -aG sudo dev

# Define current user
USER dev

# Install Prezto
RUN git clone --recursive https://github.com/sorin-ionescu/prezto.git /home/dev/.zprezto \
  && ln -s /home/dev/.zprezto/runcoms/zlogin /home/dev/.zlogin \
  && ln -s /home/dev/.zprezto/runcoms/zlogout /home/dev/.zlogout \
  && ln -s /home/dev/.zprezto/runcoms/zpreztorc /home/dev/.zpreztorc \
  && ln -s /home/dev/.zprezto/runcoms/zprofile /home/dev/.zprofile \
  && ln -s /home/dev/.zprezto/runcoms/zshenv /home/dev/.zshenv \
  && ln -s /home/dev/.zprezto/runcoms/zshrc /home/dev/.zshrc

# Set zsh as default
ENV SHELL=/bin/zsh

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /home/dev/.fzf \
  && /home/dev/.fzf/install --bin

# Install vim plug
RUN curl -fLo /home/dev/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Run dotfiles
RUN mkdir /home/dev/.config \
  && git clone https://github.com/loric-/dotfiles.git /home/dev/.config/dotfiles
RUN cd /home/dev/.config/dotfiles && python3 link.py --only-terminal

RUN lesskey

# Install vim plugins
RUN vim -c 'PlugInstall' -c 'qa!' > /dev/null

# Working dir
RUN mkdir /home/dev/Lab
WORKDIR /home/dev/Lab

# Create golang workspace paths
RUN mkdir -p /home/dev/Lab/go \
    && mkdir /home/dev/Lab/go/bin \
    && mkdir /home/dev/Lab/go/pkg \
    && mkdir /home/dev/Lab/go/src

# Save home as volume
VOLUME /home/dev

# Start zsh by default
ENTRYPOINT ["/bin/zsh"]
