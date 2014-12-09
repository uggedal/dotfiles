call pathogen#infect()

let g:gruvbox_termcolors=16
silent! colorscheme gruvbox

" Extended matching with %
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

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
let g:bufferline_fname_mod = ':.'
let g:bufferline_show_bufnr = 0
let g:bufferline_echo = 0
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
let g:bufferline_active_highlight = 'StatusLineNC'
let g:bufferline_inactive_highlight = 'StatusLine'
autocmd VimEnter *
  \ let &statusline='%{bufferline#refresh_status()}'
    \ .bufferline#get_status_string() . '%=%R%H%W %Y %14.(%l,%c%V%) %L '
