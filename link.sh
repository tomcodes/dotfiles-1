#!/bin/bash

echo "      _       _         __ _ _"
echo "   __| | ___ | |_      / _(_) | ___  ___"
echo "  / _\` |/ _ \| __|____| |_| | |/ _ \/ __|"
echo " | (_| | (_) | ||_____|  _| | |  __/\__ \\"
echo "  \__,_|\___/ \__|    |_| |_|_|\___||___/"
echo ""

# setup
echo "==> Start Setup"
cd ~/.config/prefs/

# Fetch
echo "  > Pulling latest dot-files..."
git pull &> /dev/null

# i3
echo "  > Configure i3..."
rm -rf ~/.config/i3
ln -s ~/.config/prefs/i3 ~/.config/i3

# sublime-text-3
echo "  > Configure sublime text..."
rm -rf ~/.config/sublime-text-3/Packages/User
ln -s ~/.config/prefs/sublime-text-3 ~/.config/sublime-text-3/Packages/User

# git
echo "  > Configure Git"
rm -rf ~/.gitconfig
ln -s ~/.config/prefs/git/gitconfig ~/.gitconfig
chmod +x ~/.config/prefs/git/my-git-meld

# zsh
echo "  > Configure zsh..."
rm -rf ~/.zshrc
ln -s ~/.config/prefs/zsh/zshrc ~/.zshrc

# vim
echo "  > Configure Vim..."
rm -rf ~/.vimrc
rm -rf ~/.vim/
ln -s ~/.config/prefs/vim/vimrc ~/.vimrc
ln -s ~/.config/prefs/vim/vim/ ~/.vim

# Submodules
echo "  > Fetching submodules..."
git submodule init &> /dev/null
git submodule update &> /dev/null

echo "==> Done setup"

