#/bin/sh
set -e

# rescan package index files
sudo apt-get update

# Install i3 gaps dependencies
sudo apt-get install -y \
    libxcb1-dev \
    libxcb-keysyms1-dev \
    libpango1.0-dev \
    libxcb-util0-dev \
    libxcb-icccm4-dev \
    libyajl-dev \
    libstartup-notification0-dev \
    libxcb-randr0-dev \
    libev-dev \
    libxcb-cursor-dev \
    libxcb-xinerama0-dev \
    libxcb-xkb-dev \
    libxkbcommon-dev \
    libxkbcommon-x11-dev \
    autoconf \
    libxcb-xrm-dev

sudo add-apt-repository -y ppa:aguignard/ppa
sudo apt-get update
sudo apt-get install -y libxcb-xrm-dev

# clone the repository
cd $HOME/Lab
rm -rf i3-gaps
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install
cd $HOME

# Install i3 python dependencies
sudo pip install i3-py
sudo pip2 install i3-py

# Install i3 status
sudo apt-get install -y i3status

# install i3 lock
sudo apt-get install -y i3lock scrot imagemagick xautolock

# Install rofi
sudo add-apt-repository -y ppa:aguignard/ppa
sudo apt-get update
sudo apt-get install -y rofi

# Install dunst
sudo apt-get install -y dunst

# Install other tools
sudo apt-get install -y \
    compton \
    lxappearance \
    nitrogen \
    arandr \
    blueman \
    xclip \
    gsimplecal

# Install xflux
sudo add-apt-repository -y ppa:nathan-renniewaldock/flux
sudo apt-get update
sudo apt-get install -y fluxgui

# Install greenclip
sudo rm -rf /usr/local/bin/greenclip
sudo wget https://github.com/erebe/greenclip/releases/download/3.0/greenclip
sudo chmod +x greenclip
sudo mv greenclip /usr/local/bin/greenclip

# Install playerctl
wget https://github.com/acrisci/playerctl/releases/download/v0.6.1/playerctl-0.6.1_amd64.deb
sudo DEBIAN_FRONTEND=noninteractive dpkg -i playerctl-0.6.1_amd64.deb
sudo rm -rf playerctl*

# Install arc-theme
sudo add-apt-repository -y ppa:noobslab/themes
sudo add-apt-repository -y ppa:noobslab/icons
sudo apt-get update
sudo apt-get install -y arc-theme arc-icons

# Install polybar
sudo apt-get install -y \
    cmake \
    cmake-data \
    pkg-config \
    libcairo2-dev \
    libxcb1-dev \
    libxcb-util0-dev \
    libxcb-randr0-dev \
    python-xcbgen \
    xcb-proto \
    libxcb-image0-dev \
    libxcb-ewmh-dev \
    libxcb-icccm4-dev \
    libxcb-xkb-dev \
    libxcb-xrm-dev \
    libxcb-cursor-dev \
    libasound2-dev \
    libpulse-dev \
    libjsoncpp-dev \
    libmpdclient-dev \
    libcurl4-openssl-dev \
    libiw-dev \
    libnl-3-dev

cd $HOME/Lab
rm -rf polybar
git clone --recursive https://github.com/jaagr/polybar
mkdir polybar/build
cd polybar/build
cmake ..
sudo make install
cd $HOME

# Install docker
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker $USER

# Install snapd
sudo apt-get install -y snapd

# Install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo DEBIAN_FRONTEND=noninteractive dpkg -i google-chrome-stable_current_amd64.deb
rm -rf google-chrome-stable*

# Install pantheon-files
sudo add-apt-repository -y ppa:elementary-os/daily
sudo apt-get update
sudo apt-get install -y pantheon-files
sudo ln -sf /usr/bin/io.elementary.files /usr/bin/pantheon-files

# Install apps
sudo apt-get install -y \
    rxvt-unicode-256color \
    remmina \
    firefox \
    filezilla \
    shutter \
    gnome-control-center

# install apps
sudo snap install spotify
sudo snap install sublime-text --classic
sudo snap install skype --classic
sudo snap install slack --classic
sudo snap install phpstorm --classic
