" Plugins loading
" ———————————————————————————————

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

Plug 'Shougo/deoplete.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'floobits/floobits-neovim'
Plug 'itchyny/lightline.vim'
Plug 'jodosha/vim-godebug'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mileszs/ack.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'zchee/deoplete-go', { 'do': 'make'}

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

" Gutentags
if has("autocmd")
    autocmd FileType gitcommit,gitrebase let g:gutentags_enabled=0
endif

" fzf
set rtp+=~/.fzf
noremap <Leader>t :Buffers<CR>
noremap g<Leader>t :Files<CR>
noremap <Leader>r :BTags<CR>
noremap g<Leader>r :Tags<CR>
let g:fzf_action = {
  \ 'ctrl-h': 'split',
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

" Ack
if executable('ag')
  let g:ackprg = 'ag --hidden --vimgrep'
endif
let g:ack_apply_qmappings = 0
let g:ack_apply_lmappings = 0
nnoremap <Leader>g :Ack!<Space>

" Vim Tmux Navigator
let g:tmux_navigator_no_mappings = 1
if has('nvim')
    nnoremap <silent> <A-c> :TmuxNavigateLeft<cr>
    nnoremap <silent> <A-t> :TmuxNavigateDown<cr>
    nnoremap <silent> <A-s> :TmuxNavigateUp<cr>
    nnoremap <silent> <A-r> :TmuxNavigateRight<cr>
else
    nnoremap <silent> c :TmuxNavigateLeft<cr>
    nnoremap <silent> t :TmuxNavigateDown<cr>
    nnoremap <silent> s :TmuxNavigateUp<cr>
    nnoremap <silent> r :TmuxNavigateRight<cr>
endif

" Vim Surround
let g:surround_no_mappings = 1
nmap ds <Plug>Dsurround
nmap hs <Plug>Csurround
nmap ys <Plug>Ysurround
nmap yS <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround
xmap S <Plug>VSurround
xmap gS <Plug>VgSurround
imap <C-S> <Plug>Isurround
imap <C-G>S <Plug>ISurround

" Emmet
let g:user_emmet_install_global = 0
if has("autocmd")
    autocmd FileType html,css EmmetInstall
    autocmd FileType html,css imap <expr> <c-h> emmet#expandAbbrIntelligent("\<c-h>")
endif

" Vim Go
let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled = 0
let g:go_guru_scope = ["."]
let g:go_info_mode = "guru"
if has("autocmd")
    autocmd FileType go nmap <C-t> <Plug>(go-def)
    autocmd FileType go nmap g<C-t> <Plug>(go-def-pop)
    autocmd FileType go nnoremap <Leader>r :GoDecls<CR>
    autocmd FileType go nmap <Leader>i <Plug>(go-info)
endif
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1

" Nord plugin
let g:nord_italic = 1
let g:nord_underline = 1
let g:nord_italic_comments = 1
colorscheme nord
" Redesign split
set fillchars+=vert:\│
highlight clear VertSplit

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
let g:omni_sql_no_default_maps = 1
inoremap <expr> <C-n> deoplete#mappings#manual_complete()

" Tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_map_togglesort = "k"
