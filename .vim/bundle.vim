call pathogen#infect()

colorscheme solarized

" Syntastic:
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

" CtrlP:
let g:ctrlp_map = '<leader>o'
let g:ctrlp_user_command =
    \ ['.git', 'cd %s && git ls-files . -co --exclude-standard']

" Disable unneeded HTML5 completions:
let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0
