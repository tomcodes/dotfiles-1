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

    call vundle#end()

endif

filetype plugin indent on

" Configuration for plugins
" ———————————————————————————————

" Ex file explorer
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

" NERDTree
if exists("g:loaded_nerdtree_autoload")
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
endif

" fzf
if exists('g:loaded_fzf')
    set rtp+=~/.fzf
    noremap <Leader>t :Files<CR>
    noremap <Leader>b :Buffers<CR>
    noremap <Leader>r :BTags<CR>
    noremap <Leader>R :Tags<CR>
    let g:fzf_action = {
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }
endif

" Lighline
if exists('g:loaded_lightline')
    let g:lightline = {
          \ 'colorscheme': 'solarized',
          \ }
endif

" Unimpaired
if exists("g:loaded_unimpaired")
    nmap « [
    nmap » ]
    omap « [
    omap » ]
    xmap « [
    xmap » ]
endif

" Vim session
" ———————————————————————————————
if exists('g:loaded_session')
    let g:session_autosave = 'no'
endif

"Ack
if exists('g:loaded_ack')
    if executable('ag')
      let g:ackprg = 'ag --vimgrep'
    endif
    nnoremap <Leader>f :Ack!<Space>
endif

" Vim Tmux Navigator
if exists("g:loaded_tmux_navigator")
    let g:tmux_navigator_no_mappings = 1
    nnoremap <silent> c :TmuxNavigateLeft<cr>
    nnoremap <silent> t :TmuxNavigateDown<cr>
    nnoremap <silent> s :TmuxNavigateUp<cr>
    nnoremap <silent> r :TmuxNavigateRight<cr>
endif
