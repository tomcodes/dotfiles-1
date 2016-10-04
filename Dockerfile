FROM ubuntu:16.04

MAINTAINER Loric Brevet <loric.brevet@gmail.com>

# Install usefull tools
RUN apt-get update \
  && apt-get install -y \
  sudo \
  zsh \
  vim \
  git \
  tmux \
  ranger \
  ssh \
  sshrc \
  python3 \
  python3-pip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install python packages
RUN pip3 install \
  bpython \
  ipython \
  ansible

# Create user
ENV HOME /home/dev
RUN useradd --create-home --home-dir $HOME dev \
  && chown -R dev:dev $HOME

# Define current user
WORKDIR /home/dev
USER dev

# Run dotfiles
RUN mkdir .config \
  && git clone https://github.com/loric-/dotfiles.git .config/dotfiles
RUN cd .config/dotfiles && python3 link.py

RUN lesskey

# Start zsh by default
ENTRYPOINT ["/bin/zsh"]
