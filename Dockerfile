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
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

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
WORKDIR /home/dev
USER dev

# Install oh my zsh
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git /home/dev/.oh-my-zsh

# Set zsh as default
ENV SHELL=/bin/zsh

# Install vim Vundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git /home/dev/.vim/bundle/Vundle.vim

# Run dotfiles
RUN mkdir .config \
  && git clone https://github.com/loric-/dotfiles.git .config/dotfiles
RUN cd .config/dotfiles && python3 link.py --only-terminal

RUN lesskey

# Start zsh by default
ENTRYPOINT ["/bin/zsh"]
