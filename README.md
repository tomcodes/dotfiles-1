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
    docker run --rm -ti --name dotfiles -v $(pwd):/home/dev/lab lobre/dotfiles


## Shortcut reference table

Shortcuts tend to be consistent between apps. Here is a table listing a few of them.

|                            | Home                            | Alt                            | Tmux prefix                    | Vim leader                      |
| -------------------------- | ------------------------------- | ------------------------------ | ------------------------------ | ------------------------------- |
| c/t/s/r                    | [i3] switch containers          | [tmux/vim] switch panes        | [tmux] switch panes            |                                 |
| n/p                        | [i3] next/previous workspace    | [vim] next/previous buffer     |                                |                                 |
| d                          |                                 | [vim] delete buffer            |                                |                                 |
| q                          | [i3] close window               | [vim] close window             | [tmux] close pane              |                                 |
| g                          | [i3] rofi window switcher       | [urxvt] search                 | [tmux] copy mode               | [vim] search in files           |
| b/-                        | [i3] split orientation          | [vim] split window             | [tmux] split pane              |                                 |
| z                          | [i3] full screen                |                                | [tmux] zoom pane               |                                 |
|                            |                                 |                                |                                |                                 |

## Todo

- [X] Vim quickfix navigation
- [X] Rofi clipboard manager and remove parcellite
- [ ] Color variables in Xresources
- [ ] Vim colors for folds, splits, left margin and completion bar
- [X] Vim integrate tpope plugins
- [ ] i3 auto update when display switched
- [ ] Test docker image
- [X] Test features over SSH
- [ ] Check vim ssh sessions (quick open vim session with rofi)
- [X] rofi search through all open windows with HOME+g
- [ ] Xresources grey color to be changed for zsh prompt and htop values
- [ ] Vim can't copy in insert mode
- [X] Vim plugin (or NERDTree?) for creating/renaming/deleting files
- [X] Vim autocmd for NERDTree
- [X] Vim review emmet mappings
- [ ] Dockerfile install golang
