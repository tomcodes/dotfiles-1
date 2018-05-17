# DOTFILES

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


## Install script

A python 3 script has been created to easily symlink files.

    python3 link.py

## Docker

A Dockerfile is implemented to build an environment with only terminal based applications.

    docker build -t lobre/dotfiles .
    docker run --rm -ti --name dotfiles -v $(pwd):/home/dev/lab lobre/dotfiles


## Shortcut reference table

Shortcuts tend to be consistent between apps. Here is a table listing a few of them.

|                            | Home                       | Alt                       | Tmux prefix               | Vim leader                 | Ctrl                       |
| -------------------------- | -------------------------- | ------------------------- | ------------------------- | -------------------------- | -------------------------- |
| c/t/s/r                    | Switch i3 containers       | Switch tmux+vim panes     | Switch tmux panes         |                            |                            |
| n/p                        | Next/Previous i3 workspace |                           |                           |                            | Next/Previous vim buffer   |
| d                          |                            | Delete vim buffer         |                           |                            |                            |
| q                          | Close i3 window            | Close vim window          | Close tmux pane           |                            |                            |
| g                          |                            | Search urxvt              | Copy mode in tmux         | Search in vim files        |                            |
| b/-                        | i3 split orientation       | vim split window          | tmux split panes          |                            |                            |
| z                          | Full screen i3             |                           | tmux zoom pane            |                            |                            |
|                            |                            |                           |                           |                            |                            |

## Todo

- [ ] Vim quickfix navigation
- [ ] Rofi clipboard manager and remove parcellite
- [ ] Color variables in Xresources
- [ ] Vim colors for folds, splits, left margin and completion bar
- [ ] Vim integrate tpope plugins
- [ ] i3 auto update when display switched
- [ ] Test docker image
- [X] Test features over SSH
- [ ] Check vim ssh sessions (quick open vim session with rofi)
- [ ] rofi search through all open windows with HOME+g
- [ ] Xresources grey color to be changed for zsh prompt and htop values
- [ ] Vim can't copy in insert mode
- [ ] Vim plugin (or NERDTree?) for creating/renaming/deleting files
- [ ] Vim autocmd for NERDTree
- [ ] Vim review emmet mappings
- [ ] Dockerfile install golang
