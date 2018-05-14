" VIM Configuration 
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

" Activation de Vundle
" ———————————————————————————————
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

runtime! bundle/Vundle.vim/autoload/vundle.vim
if exists("*vundle#begin")

    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'

    " Vundle plugins
    Plugin 'scrooloose/nerdtree'
    Plugin 'ludovicchabant/vim-gutentags'
    Plugin 'itchyny/lightline.vim'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'mattn/emmet-vim'
    Plugin 'xolox/vim-misc'
    Plugin 'xolox/vim-session'
    Plugin 'chriskempson/base16-vim'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-fugitive'
    Plugin 'haya14busa/incsearch.vim'
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'
    Plugin 'mileszs/ack.vim'
    Plugin 'sheerun/vim-polyglot'
    Plugin 'christoomey/vim-tmux-navigator'
    Plugin 'vim-vdebug/vdebug'
    Plugin 'w0rp/ale'

    call vundle#end()

endif

filetype plugin indent on

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

" Remap debut de ligne
noremap è ^
noremap È 0

" Changement de la touche leader
let mapleader = "\<Space>"

" Remap esc to avoid delay
imap <Esc> <C-c>

" Save and quit shortcuts
nnoremap <Leader>w :w!<CR>
nnoremap <Leader>s :w!<CR>
nnoremap <Leader>q :q!<CR>

" Center the screen
nnoremap <Leader>z zz

" Copy paste shortcuts
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Remap jump to/from tags
nnoremap <C-t> <C-]>
nnoremap g<C-t> <C-t>

" Default tabs count parameters
set tabstop=2
set shiftwidth=2
set expandtab

" Tabs for python
autocmd Filetype python setlocal ts=4 sw=4 expandtab

" Save with sudo
command! W w !sudo tee % > /dev/null

" Regenerate ctags
nnoremap <f5> :!ctags -R<CR>

" Fold
nnoremap <leader><space> za
vnoremap <leader><space> zf

" Buffer shortcuts
nmap <C-e> :e#<CR>
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>
nmap d :bd<CR>

" BÉPO CONFIG
" ———————————————————————————————

" {W} -> [É]
" ——————————
" On remappe W sur É :
noremap é w
noremap É W
" Corollaire: on remplace les text objects aw, aW, iw et iW
" pour effacer/remplacer un mot quand on n’est pas au début (daé / laé).
onoremap aé aw
onoremap aÉ aW
onoremap ié iw
onoremap iÉ iW
" Pour faciliter les manipulations de fenêtres, on utilise {W} comme un Ctrl+W :
noremap w <C-w>
noremap W <C-w><C-w>
 
" [HJKL] -> {CTSR}
" ————————————————
" {cr} = « gauche / droite »
noremap c h
noremap r l
" {ts} = « haut / bas »
noremap t j
noremap s k
" {CR} = « haut / bas de l'écran »
noremap C H
noremap R L
" {TS} = « joindre / aide »
noremap T J
noremap S K
" Corollaire : repli suivant / précédent
noremap zs zj
noremap zt zk
 
" {HJKL} <- [CTSR]
" ————————————————
" {J} = « Jusqu'à »            (j = suivant, J = précédant)
noremap j t
noremap J T
" {L} = « Change »             (l = attend un mvt, L = jusqu'à la fin de ligne)
noremap l c
noremap L C
" {H} = « Remplace »           (h = un caractère slt, H = reste en « Remplace »)
noremap h r
noremap H R
" {K} = « Substitue »          (k = caractère, K = ligne)
noremap k s
noremap K S
" Corollaire : correction orthographique
noremap ]k ]s
noremap [k [s
 
" Désambiguation de {g}
" —————————————————————
" ligne écran précédente / suivante (à l'intérieur d'une phrase)
noremap gs gk
noremap gt gj
" onglet précédant / suivant
noremap gb gT
noremap gé gt
" optionnel : {gB} / {gÉ} pour aller au premier / dernier onglet
noremap gB :exe "silent! tabfirst"<CR>
noremap gÉ :exe "silent! tablast"<CR>
" optionnel : {g"} pour aller au début de la ligne écran
noremap g" g0
 
" <> en direct
" ————————————
noremap « <
noremap » >
 
" Remaper la gestion des fenêtres
" ———————————————————————————————
noremap t <C-w>j
noremap s <C-w>k
noremap c <C-w>h
noremap r <C-w>l
noremap q <C-w>c
noremap o <C-w>s
noremap p <C-w>o
noremap <SPACE> :split<CR>
noremap <CR> :vsplit<CR>

" Remap Ex file explorer
" ———————————————————————————————
if has("autocmd")
augroup netrw_dvorak_fix
    autocmd!
    autocmd filetype netrw call Fix_netrw_maps_for_dvorak()
augroup END
function! Fix_netrw_maps_for_dvorak()
    noremap <buffer> t j
    noremap <buffer> s k
    noremap <buffer> k s
endfunction
endif

" Remap NERDTree
" ———————————————————————————————
let g:NERDTreeMapChdir = 'H'
let g:NERDTreeMapChdir = 'hd'
let g:NERDTreeMapCWD = 'HD'
let g:NERDTreeMapOpenInTab = 'j'
let g:NERDTreeMapJumpLastChild = 'J'
let g:NERDTreeMapOpenVSplit = 'k'
let g:NERDTreeMapRefresh = 'l'
let g:NERDTreeMapRefreshRoot = 'L'
let g:NERDTreeMapHelp='<f1>'
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :NERDTreeCWD<CR>
nnoremap <F4> :NERDTreeFind<CR>

" Remap fzf
" ———————————————————————————————
set rtp+=~/.fzf
noremap <Leader>t :Files<CR>
noremap <Leader>b :Buffers<CR>
noremap <Leader>e :Tags<CR>
let g:fzf_action = {
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Lighline
" ———————————————————————————————
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

" Unimpaired
" ———————————————————————————————
nmap « [
nmap » ]
omap « [
omap » ]
xmap « [
xmap » ]

" Vim session
" ———————————————————————————————
let g:session_autosave = 'no'

" Inc search
" ———————————————————————————————
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Vim Tmux Navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> c :TmuxNavigateLeft<cr>
nnoremap <silent> t :TmuxNavigateDown<cr>
nnoremap <silent> s :TmuxNavigateUp<cr>
nnoremap <silent> r :TmuxNavigateRight<cr>
