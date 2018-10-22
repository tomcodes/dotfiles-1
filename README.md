# DOTFILES

Configuration files for linux

![Screenshot](https://github.com/lobre/dotfiles/raw/master/screenshot.png)

Shortcuts have been designed to be used with a Bépo keyboard layout. Here are the tools included.

 - i3wm
 - tmux
 - vim
 - less
 - sublime text
 - ranger
 - zshrc
 - sshrc

Graphical and terminal application configurations are split in two different folders.

## Install script

A python 3 script has been created to easily symlink files.

    python3 link.py

## Docker

A Dockerfile is implemented to build an environment with only terminal based applications.

    docker build -t lobre/dotfiles .
    docker run --rm -ti --name dotfiles -e TERM=$TERM -v $(pwd):/home/dev/Lab lobre/dotfiles

## Vagrant

A Vagrantfile at the root of the project allows the provisioning of an Ubuntu 16.04 box with all the graphical and terminal tools installed.

First, make sure to have the following vagrant plugins installed.

	vagrant plugin update vagrant-vbguest
	vagrant plugin install vagrant-disksize

And you can launch and provision the box as followed.

    vagrant up
    vagrant provision

It takes around 30 min to provision the whole box.

Then, the package control for sublime text has to be manually installed. `lxappearance` can help changing the gtk theme and `nitrogen` can be used for setting a wallpaper.

It is also a good idea to change the VirtualBox host key to the "Applications" key. It can be handy as well to remove useless key combinations on the Virtual machine.

### How to reinstall vbguest

Sometimes, it happens that vbguest is updating in the VM and that leads with a difference of versions with the host. This may bring error. To re-align vbguest, use the following from inside the box.

    cd /opt/VBoxGuestAdditions-<version_number>
    sudo ./uninstall.sh

Then, restart the box. The vbguest plugin should re-install the correct version.

## Shortcut reference table

Shortcuts tend to be consistent between apps. Here is a table listing a few of them.

|                            | Home                            | Alt                            | Tmux prefix                    | Vim leader                      |
| -------------------------- | ------------------------------- | ------------------------------ | ------------------------------ | ------------------------------- |
| c/t/s/r                    | [i3] switch containers          | [tmux/vim] switch panes        | [tmux] switch panes            |                                 |
| n/p                        | [i3] next/previous workspace    | [vim] next/previous buffer     |                                |                                 |
| d                          | [dunst] close notification      | [vim] delete buffer            |                                |                                 |
| q                          | [i3] close window               | [vim] close window             | [tmux] close pane              |                                 |
| g                          | [i3] rofi window switcher       | [urxvt] search                 | [tmux] copy mode               | [vim] search in files           |
| b/-                        | [i3] split orientation          | [vim] split window             | [tmux] split pane              |                                 |
| z                          | [i3] full screen                |                                | [tmux] zoom pane               |                                 |
|                            |                                 |                                |                                |                                 |

## Colors

Colors are generated from a base 16 template. See `.Xresources` to check colors. These colors are propagated from X resources to other apps.

 - Uxrvt
 - Rofi
 - i3
 - Polybar
 - Dunst

Colors can be easily visualized using https://terminal.sexy.

## Visual Studio Code

The configuration of `vscode` is saved in this repo but the list of extensions does not save automatically. Here is the command to update the list of extensions.

    code --list-extensions | xargs -L 1 echo code --install-extension >| graphical/.config/Code/extensions.sh

This script can then be used to restore and install extensions.

## Todo

*Nothing up so far*
