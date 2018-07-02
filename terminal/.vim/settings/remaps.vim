" Custom Remaps
" ———————————————————————————————

" Remap <C-c> in visual for visual block
vnoremap <C-c> <Esc>
inoremap <C-c> <Esc>

" Save and quit shortcuts
noremap <C-s> :w!<CR>
noremap w :w!<CR>
noremap q :q!<CR>
noremap <Leader>q :qa!<CR>

" Primary buffer copy paste
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Remap jump to/from tags
nnoremap <C-t> <C-]>
nnoremap g<C-t> <C-t>

" Save with sudo
command! W w !sudo tee % > /dev/null

" Fold
nnoremap <leader><space> za
vnoremap <leader><space> zf

" Buffer shortcuts
nnoremap e :e#<CR>
nnoremap n :bnext<CR>
nnoremap p :bprev<CR>
nnoremap d :bd!<CR>

" Remove highlight (<C-/> works as well)
nnoremap <C-_> :set hlsearch!<CR>

" Remaper la gestion des fenêtres
noremap t <C-w>j
noremap s <C-w>k
noremap c <C-w>h
noremap r <C-w>l
noremap o <C-w>o
noremap - :split<CR>
noremap b :vsplit<CR>

" Smart completion
function! Smart_TabComplete()
    let line = getline('.')
    let substr = strpart(line, -1, col('.')+1)
    let substr = matchstr(substr, "[^ \t]*$")
    if (strlen(substr)==0)
      return "\<tab>"
    endif
    let has_period = match(substr, '\.') != -1
    let has_slash = match(substr, '\/') != -1
    if (!has_period && !has_slash)
      return "\<C-X>\<C-P>"
    elseif ( has_slash )
      return "\<C-X>\<C-F>"
    else
      return "\<C-X>\<C-O>"
    endif
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>
