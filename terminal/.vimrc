" VIM Configuration 
" ———————————————————————————————

" Edit leader key
let mapleader = "\<Space>"

" If in SSH session
if $SSHHOME != ''
     set runtimepath+=$SSHHOME/.sshrc.d/.vim
endif

" General configurations
runtime settings/general.vim
" Keybindings and custom remaps
runtime settings/remaps.vim

" If not in SSH session
if $SSHHOME == ''
    " Plugins and plugins related configurations
    runtime settings/plugins.vim
endif

" Allow to add additional configuration without needing to commit
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
