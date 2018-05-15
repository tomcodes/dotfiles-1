" VIM Configuration 
" ———————————————————————————————

" Load custom configurations
runtime! init/*.vim

" Allow to add configuration without needing to commit
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
