call pathogen#infect()

if &term =~ "screen-256"
  let g:solarized_termcolors=256
else
  let g:solarized_termcolors=16
endif
colorscheme solarized

" Automatically close syntastic error window when no errors are detected:
let g:syntastic_auto_loc_list=2

" Mark syntastic errors:
let g:syntastic_enable_signs=1
