#!/bin/bash

# Create automatic links

# i3
rm -rf ~/.config/i3
ln -s ~/.config/prefs/i3 ~/.config/i3

# sublime-text-3
rm -rf ~/.config/sublime-text-3/Packages/User
ln -s ~/.config/prefs/sublime-text-3 ~/.config/sublime-text-3/Packages/User

# git
rm -rf ~/.gitconfig
ln -s ~/.config/prefs/git/gitconfig ~/.gitconfig
chmod +x ~/.config/prefs/git/my-git-meld

# zsh
rm -rf ~/.zshrc
ln -s ~/.config/prefs/zsh/zshrc ~/.zshrc

# vim
rm -rf ~/.vimrc
rm -rf ~/.vim/
ln -s ~/.config/prefs/vim/vimrc ~/.vimrc
ln -s ~/.config/prefs/vim/vim/ ~/.vim
cd ~/.config/prefs/
git submodule init
git submodule update

