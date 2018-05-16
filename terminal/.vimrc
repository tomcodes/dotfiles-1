" VIM Configuration 
" ———————————————————————————————

" General configurations
source $HOME/.vim/settings/general.vim
" Keybindings and custom remaps
source $HOME/.vim/settings/remaps.vim
" Plugins and plugins related configurations
source $HOME/.vim/settings/plugins.vim
" Fundamental bepo mappings
source $HOME/.vim/settings/bepo.vim

" Allow to add additional configuration without needing to commit
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
