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

" Disable unneeded HTML5 completions:
let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0

" Ctrl-P mappings for tab usage:
let g:ctrlp_map = '<leader>o'
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<c-t>'],
  \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
  \ }
let g:ctrlp_open_new_file = 't'

" DWM custom mappings:
let g:dwm_map_keys = 0

map <C-N> :call DWM_New()<CR>
map <C-C> :call DWM_Close()<CR>
map <C-H> :call DWM_Focus()<CR>
map <C-J> <C-W>w
map <C-K> <C-W>W
map <C-L> :ls<CR>
