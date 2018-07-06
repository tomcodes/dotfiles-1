" General configurations
" ———————————————————————————————

" Use vim settings rather then vi settings
set nocompatible

" Set encoding
scriptencoding utf-8
set encoding=utf-8

" Always show statusline
set laststatus=2
set noshowmode

" Add current directory to path variable
set path=$PWD/**

" Explorer shown as tree
let g:netrw_liststyle=3

" Customize grep program
set grepprg=grep\ -RIin\ --exclude=tags\ $*\ 2>/dev/null

" Move swp and backup files location
set backupdir=~/tmp,~/
set directory=~/tmp,/var/tmp,/tmp

" This will cause all yank/delete/paste operations to use the system register
set clipboard=unnamed

" -- Display
set number relativenumber    " Show smart line numbers
set ruler                    " Show position of cursor
set wrap                     " Long lines on multiple lines
set scrolloff=3              " 3 lines displayed around cursor for scroll

" -- Searching
set ignorecase          " Case insensitive
set wildignorecase      " Autocomplete case insensitive
set smartcase           " Enable case sensitivity if search contains upper letter
set incsearch           " Highlight search result while inputing
set hlsearch            " Highlight search results

" -- Autocomplete
set wildmenu                    " Show possible completions on command line
set wildmode=longest:full,full  " List all options and complete
set wildignore=*.class,*.o,*~,*.pyc,.git,node_modules  " Ignore certain files in tab-completion
set completeopt=longest,menuone

" -- Beep
set novisualbell        " Prevent bell
set noerrorbells        " Prevent bell

" Default tabs count parameters
set tabstop=4
set shiftwidth=4
set expandtab

" Common behavior for backspace
set backspace=indent,eol,start

" Enable caching on buffer switch
set hidden

" Enable file types and indents
filetype on
filetype plugin on
filetype indent on

" Font
set guifont=Droid\ Sans\ Mono\ 10

" Colorscheme
syntax on
set background=dark
colorscheme default

" Don't color folded lines
hi Folded ctermbg=NONE

" Autocmd
if has("autocmd")

    " Ex file explorer
    augroup netrw_dvorak_fix
        autocmd!
        autocmd filetype netrw call Fix_netrw_maps_for_dvorak()
    augroup END
    function! Fix_netrw_maps_for_dvorak()
        noremap <buffer> t j
        noremap <buffer> s k
        noremap <buffer> k s
    endfunction

    " Smart number of lines
    augroup numbertoggle
      autocmd!
      autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
      autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
    augroup END

endif
