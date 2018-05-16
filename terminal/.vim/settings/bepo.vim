" Bepo related configurations
" ———————————————————————————————

" Use é and è
noremap é w
noremap É W
noremap è ^
noremap È 0

" Remap text objects with é
onoremap aé aw
onoremap aÉ aW
onoremap ié iw
onoremap iÉ iW

" Use w for windows manipulations
noremap w <C-w>
noremap W <C-w><C-w>
 
" [HJKL] -> {CTSR}
" ————————————————
" Left
noremap c h
" Right
noremap r l
" Down
noremap t j
" Up
noremap s k
" Top of screen
noremap C H
" Bottom of screen
noremap R L
" Join
noremap T J
" Help under cursor
noremap S K
" Previous fold
noremap zs zk
" Next fold
noremap zt zj
 
" {HJKL} <- [CTSR]
" ————————————————
" Until motion
noremap j t
" Until backward
noremap J T
" Change followed by motion
noremap l c
" Change til end of line
noremap L C
" Replace single char
noremap h r
" Replace mode
noremap H R
" Substitute one char
noremap k s
" Substitute entire line
noremap K S
" Spellcheck
noremap ]k ]s
noremap [k [s
 
" Remap g keymaps
" —————————————————————
" Up next visible line
noremap gs gk
" Down next visible line
noremap gt gj
" Previous tab
noremap gb gT
" Next tab
noremap gé gt
" Goto first tab
noremap gB :exe "silent! tabfirst"<CR>
" Goto last tab
noremap gÉ :exe "silent! tablast"<CR>
" Goto beginning of visible line
noremap g" g0

" <> easy access
noremap « <
noremap » >
