" Avoid a 'timeoutlen' delay (due to vim-unimpaired's "co" mapping)
if !empty(maparg('co', 'n'))
    nunmap co
endif
