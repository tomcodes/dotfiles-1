" Avoid a 'timeoutlen' delay (due to vim-unimpaired's "co" and "cop" mappings)
if !empty(maparg('co', 'n'))
    nunmap co
    nunmap cop
endif
