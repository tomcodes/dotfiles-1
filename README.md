# DOTFILES

Configuration files for linux

![Screenshot](/screenshot.png)

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
    docker run --rm -ti --name dotfiles -v $(pwd):/home/dev/Lab lobre/dotfiles


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

## Todo

- [ ] Test docker image
- [ ] Dockerfile install golang
