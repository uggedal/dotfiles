call pathogen#infect()

let g:loaded_togglebg = 1
silent! colorscheme solarized

" No grey bg in sign gutter
hi! SignColumn ctermbg=NONE

" Syntastic:
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['java'] }

" JSON:
autocmd BufNewFile,BufRead *.json setlocal conceallevel=0

" Bufferline:
let g:bufferline_show_bufnr = 0
