call pathogen#infect()

silent! colorscheme base16-default

" No grey bg in sign gutter
hi! SignColumn ctermbg=NONE

" Syntastic:
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

" SelectBuf:
nmap <unique> <silent> <Leader>o <Plug>SelectBuf
let g:selBufAlwaysShowPaths=1
let g:selBufDefaultSortOrder="number"
let g:selBufDisableMRUlisting=1
let g:selBufShowHelpHint=0
