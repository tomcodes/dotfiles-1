#!/bin/bash
set -e

# Install ppa
sudo apt-get update \
    && sudo DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common \
    && sudo add-apt-repository -y ppa:neovim-ppa/unstable \
    && sudo add-apt-repository ppa:git-core/ppa

# Install packages
sudo apt-get update \
    && sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
      acpi \
      ansible \
      autojump \
      ctags \
      curl \
      dos2unix \
      git \
      glances \
      htop \
      httpie \
      iftop \
      iotop \
      iputils-ping \
      jq \
      man-db \
      mercurial \
      neovim \
      net-tools \
      netcat \
      nethogs \
      nload \
      openvpn \
      pv \
      python \
      python-pip \
      python3 \
      python3-pip \
      ranger \
      snapd \
      ssh \
      stress \
      tcpdump \
      telnet \
      tmux \
      traceroute \
      tree \
      tty-clock \
      wget \
      wordnet \
      zsh

# Install golang
sudo rm -rf /usr/local/go*
sudo wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz \
    && sudo tar -xvf go1.10.3.linux-amd64.tar.gz \
    && sudo mv go /usr/local \
    && sudo rm go*

# Install python packages
sudo pip install \
  speedtest-cli \
  neovim \
  cheat \
  --upgrade

sudo pip3 install \
  bpython \
  ipython \
  neovim \
  --upgrade

# Install snapd and snap packages
sudo snap install node --classic --channel 9/stable
sudo snap install ripgrep --classic && sudo snap alias ripgrep.rg rg

# Install sshrc
sudo rm -rf /usr/local/bin/sshrc
sudo wget https://raw.githubusercontent.com/Russell91/sshrc/master/sshrc \
  && sudo chmod +x sshrc \
  && sudo mv sshrc /usr/local/bin

# Install Prezto
rm -rf $HOME/.zprezto $HOME/.zlogin $HOME/.zlogout $HOME/.zpreztorc $HOME/.zprofile $HOME/.zshenv $HOME/.zshrc
git clone --recursive https://github.com/sorin-ionescu/prezto.git $HOME/.zprezto \
  && ln -s $HOME/.zprezto/runcoms/zlogin $HOME/.zlogin \
  && ln -s $HOME/.zprezto/runcoms/zlogout $HOME/.zlogout \
  && ln -s $HOME/.zprezto/runcoms/zpreztorc $HOME/.zpreztorc \
  && ln -s $HOME/.zprezto/runcoms/zprofile $HOME/.zprofile \
  && ln -s $HOME/.zprezto/runcoms/zshenv $HOME/.zshenv \
  && ln -s $HOME/.zprezto/runcoms/zshrc $HOME/.zshrc

# Install fzf
rm -rf $HOME/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf \
  && $HOME/.fzf/install --bin

# Install vim plug
rm -rf $HOME/.vim/autoload/plug.vim
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Working dir
if [ ! -d "$HOME/Lab" ]; then
    mkdir $HOME/Lab

    # Create golang workspace paths
    mkdir -p $HOME/Lab/go \
        && mkdir $HOME/Lab/go/bin \
        && mkdir $HOME/Lab/go/pkg \
        && mkdir $HOME/Lab/go/src
fi
