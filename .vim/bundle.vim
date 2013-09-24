call pathogen#infect()

silent! colorscheme base16-default

" No grey bg in sign gutter
hi! SignColumn ctermbg=NONE

" Syntastic:
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_filetype_checkers['java'] = []

" MiniBufExpl:
let g:miniBufExplStatusLineText="--"

" JSON:
autocmd BufNewFile,BufRead *.json setlocal conceallevel=0
