" General configurations
" ———————————————————————————————

" Annule la compatibilite avec l’ancetre Vi : totalement indispensable
set nocompatible

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Always show statusline
set laststatus=2
set noshowmode

" Explorer show as tree
let g:netrw_liststyle=3

" Add current directory to path variable
set path=$PWD/**

" Customize grep
set grepprg=grep\ -RIin\ --exclude=tags\ $*\ 2>/dev/null

" Move swp and backup files location
set backupdir=~/tmp,~/
set directory=~/tmp,/var/tmp,/tmp

" Set smart relative number
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" -- Affichage
set title                 " Met a jour le titre de votre fenetre ou de votre terminal
set number                " Affiche le numero des lignes
set ruler                 " Affiche la position actuelle du curseur
set wrap                  " Affiche les lignes trop longues sur plusieurs lignes
set scrolloff=3           " Affiche un minimum de 3 lignes autour du curseur (pour le scroll)

" -- Recherche
set ignorecase          " Ignore la casse lors d’une recherche
set wildignorecase      " Autocompletion qui ignore aussi la casse pour les fichiers
set smartcase           " Si une recherche contient une majuscule, re-active la sensibilite a la casse
set incsearch           " Surligne les resultats de recherche pendant la saisie
set hlsearch            " Surligne les resultats de recherche

" -- Autocomplete
set wildmenu                " Show possible completions on command line
set wildmode=list:longest,full " List all options and complete
set wildignore=*.class,*.o,*~,*.pyc,.git,node_modules  " Ignore certain files in tab-completion

" -- Beep
set visualbell          " Empeche Vim de beeper
set noerrorbells        " Empeche Vim de beeper

" Active le comportement ’habituel’ de la touche retour en arriere
set backspace=indent,eol,start

" Cache les fichiers lors de l’ouverture d’autres fichiers
set hidden

" Active les comportements specifiques aux types de fichiers comme la syntaxe et l’indentation
filetype on
filetype plugin on
filetype indent on

" Police
set guifont=Droid\ Sans\ Mono\ 10
set antialias

" Main color scheme
set background=dark

" Colorscheme
syntax on
set t_Co=256
silent! colorscheme delek
