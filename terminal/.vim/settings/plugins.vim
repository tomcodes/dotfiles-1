" Plugins loading with Vundle
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
    Plugin 'haya14busa/is.vim'
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'
    Plugin 'mileszs/ack.vim'
    Plugin 'sheerun/vim-polyglot'
    Plugin 'christoomey/vim-tmux-navigator'
    Plugin 'vim-vdebug/vdebug'
    Plugin 'w0rp/ale'
    Plugin 'godlygeek/tabular'
    Plugin 'editorconfig/editorconfig-vim'

    call vundle#end()

endif

filetype plugin indent on

" Configuration for plugins
" ———————————————————————————————

" NERDTree
let g:NERDTreeMapChdir = 'H'
let g:NERDTreeMapChdir = 'hd'
let g:NERDTreeMapCWD = 'HD'
let g:NERDTreeMapOpenInTab = 'j'
let g:NERDTreeMapJumpLastChild = 'J'
let g:NERDTreeMapOpenVSplit = 'k'
let g:NERDTreeMapRefresh = 'l'
let g:NERDTreeMapRefreshRoot = 'L'
let g:NERDTreeMapHelp='<f1>'
noremap <C-n> :NERDTreeToggle<CR>
noremap g<C-n> :NERDTreeFind<CR>

" fzf
set rtp+=~/.fzf
noremap <Leader>t :Files<CR>
noremap <Leader>b :Buffers<CR>
noremap <Leader>r :BTags<CR>
noremap <Leader>R :Tags<CR>
let g:fzf_action = {
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Lighline
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

" Unimpaired
nmap « [
nmap » ]
omap « [
omap » ]
xmap « [
xmap » ]

" Vim session
let g:session_autosave = 'no'

"Ack
if executable('ag')
  let g:ackprg = 'ag --hidden --vimgrep'
endif
nnoremap <Leader>f :Ack!<Space>

" Vim Tmux Navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> c :TmuxNavigateLeft<cr>
nnoremap <silent> t :TmuxNavigateDown<cr>
nnoremap <silent> s :TmuxNavigateUp<cr>
nnoremap <silent> r :TmuxNavigateRight<cr>
