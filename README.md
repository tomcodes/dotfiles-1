DOTFILES
=====

Configuration files for linux

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

## Install

A python 3 script has been created to easily symlink files.

    python3 link.py

## Docker

A Dockerfile is implemented to build an environment with only terminal based applications.

    docker build -t lobre/dotfiles .
    docker run --rm -ti --name dotfiles -v $(pwd):/home/dev/lab lobre/dotfiles


## Shortcut reference table

Shortcuts tend to be consistent between apps. Here is a table listing a few of them.

|                            | Home                       | Alt                       | Tmux prefix               | Ctrl                       |
| -------------------------- | -------------------------- | ------------------------- | ------------------------- | -------------------------- |
| c/t/s/r                    | Switch i3 containers       | Switch tmux+vim panes     | Switch tmux panes         |                            |
| n/p                        | Next/Previous i3 workspace |                           |                           | Next/Previous vim buffer   |
| d                          |                            | Delete vim buffer         |                           |                            |
| q                          | Close i3 window            | Close vim window          | Close tmux pane           |                            |
| g                          |                            |                           |                           |                            |
| b/-                        | i3 split orientation       | vim split window          | tmux split panes          |                            |
|                            |                            |                           |                           |                            |

## Todo

- [ ] Vim quickfix navigation
- [ ] Rofi clipboard manager and remove parcellite
- [ ] Color variables in Xresources
- [ ] Vim colors for folds, splits and completion bar
- [ ] Vim integrate tpope plugins
- [ ] i3 auto update when display switched
- [ ] Test docker image
- [ ] Test features over SSH
- [ ] Check vim ssh sessions (quick open vim session with rofi)
