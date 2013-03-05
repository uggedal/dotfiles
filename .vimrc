" vim: filetype=vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible     " vim mode

set undofile         " persist undo tree
set history=100      " lines of command line history

set undodir=~/.vim/tmp/undo//,/tmp//    " undo files
set directory=~/.vim/tmp/swap//,/tmp//  " swap files

set autoread         " read a unchanged file if it's been changed outside vim

set ruler            " show line and column number of cursor position
set showcmd          " display incomplete commands

set shortmess+=I     " don't show splash screen


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color and Syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=light

syntax on 
filetype plugin indent on        " language dependent indenting


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User Interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start " allow backspacing over items

set incsearch                  " display search results incrementally
set hlsearch                   " highligh all search matches
set smartcase                  " ignore case on lower letter search
set gdefault                   " default substitute all changes on a line

" Disable bells:
set noerrorbells
set novisualbell
set t_vb=

set wildmode=longest,list,full " shell like tab completion behavior
set wildignore+=*.pyc,*.png

autocmd InsertLeave * set nocursorline " no cursorline in normal mode
autocmd InsertEnter * set cursorline   " cursorline in insert mode
autocmd FileType help wincmd L         " Open help window in vertical split
nnoremap K <nop>                       " kill manual key


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Movement
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" We have to learn to use h, j, k, l
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Disable tab shortcuts:
nnoremap gT <nop>
nnoremap gt <nop>

" Move up and down in screen lines, not file lines:
nnoremap j gj
nnoremap k gk

" Split movement shortcuts:
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set scrolloff=3   " Display next/prev 3 lines after/before cursor

" Allow moving cursor past end of line in visual block mode:
set virtualedit+=block

" Keep search matches in the middle of the window:
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab      " expand tabs to spaces
set tabstop=2      " width of an actual tab char in spaces
set softtabstop=2  " width of an inserted tab char
set shiftwidth=2   " number of spaces for each indent
set smarttab       " inserts spaces according to shiftwidt when <TAB>

set wrap           " visually wrap lines longer than the window

set colorcolumn=80 " mark lines over 80 columns


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Languages
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" JSON syntax highlighting:
au BufNewFile,BufRead *.json setlocal ft=javascript

" Salt state syntax highlighting:
au BufNewFile,BufRead *.sls setlocal ft=yaml

" 4 spaces for Python:
au FileType python setl softtabstop=4 tabstop=4 shiftwidth=4

" Tabs for Go:
au FileType go setl noexpandtab softtabstop=0 tabstop=4 shiftwidth=4 nosmarttab


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusbar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=%02n\ %f%m%r%h%w\ %y
set statusline+=%=%-14.(%l,%c%V%)\ %L

set laststatus=2


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Avoid pinky stretch for '\':
let mapleader = ","

" Buffer movement:
nnoremap <Leader>b :ls<CR>
nnoremap <Leader>p :bp<CR>
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>g :b#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

" Toggle paste mode for no autoindenting:
nnoremap <leader>i :set invpaste<CR>

" Opens an edit command with the path of the current file filled in
nnoremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Create vertical split and navigate to it:
nnoremap <leader>w <C-w>v<C-w>l

" Clear search highlights:
nnoremap <leader>c :noh<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" always jump to the last known cursor position
augroup vimrcEx
  au!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

runtime bundle.vim
