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
  tree \
  httpie \
  acpi \
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

# Install vim Vundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git /home/dev/.vim/bundle/Vundle.vim

# Run dotfiles
RUN mkdir /home/dev/.config \
  && git clone https://github.com/loric-/dotfiles.git /home/dev/.config/dotfiles
RUN cd /home/dev/.config/dotfiles && python3 link.py --only-terminal

# Install vim Vundle plugins
RUN vim -c 'PluginInstall' -c 'qa!' > /dev/null

RUN lesskey

# Working dir
RUN mkdir /home/dev/lab
WORKDIR /home/dev/lab

# Save home as volume
VOLUME /home/dev

# Start zsh by default
ENTRYPOINT ["/bin/zsh"]
