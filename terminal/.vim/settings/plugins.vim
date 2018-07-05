" Plugins loading
" ———————————————————————————————

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'ludovicchabant/vim-gutentags'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'haya14busa/is.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'sheerun/vim-polyglot'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-vdebug/vdebug'
Plug 'w0rp/ale'
Plug 'godlygeek/tabular'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'tpope/vim-eunuch'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-characterize'
Plug 'ryanoasis/vim-devicons'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

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
if has("autocmd")
    " Close vim if only NERDTree window opened
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif

" fzf
set rtp+=~/.fzf
noremap <Leader>t :Files<CR>
noremap <Leader>b :Buffers<CR>
noremap <Leader>r :BTags<CR>
noremap <Leader>R :Tags<CR>
nnoremap <C-t> :call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1 --exit-0'})<CR>
let g:fzf_action = {
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Lighline
let g:lightline = { 'colorscheme': 'solarized' }

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
let g:ack_apply_qmappings = 0
let g:ack_apply_lmappings = 0
nnoremap <Leader>g :Ack!<Space>

" Vim Tmux Navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> c :TmuxNavigateLeft<cr>
nnoremap <silent> t :TmuxNavigateDown<cr>
nnoremap <silent> s :TmuxNavigateUp<cr>
nnoremap <silent> r :TmuxNavigateRight<cr>

" Vim Surround
let g:surround_no_mappings = 1
nmap ds  <Plug>Dsurround
nmap hs  <Plug>Csurround
nmap ys  <Plug>Ysurround
nmap yS  <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround
xmap S   <Plug>VSurround
xmap gS  <Plug>VgSurround
imap    <C-S> <Plug>Isurround
imap    <C-G>S <Plug>ISurround

" Emmet
let g:user_emmet_leader_key='<C-e>'

" Vim Go
let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled = 0
