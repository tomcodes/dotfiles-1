" Keys and remaps
" ———————————————————————————————

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
