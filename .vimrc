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
set number

set shortmess+=I     " don't show splash screen


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color and Syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark

syntax enable
set synmaxcol=200                " don't highlight long lines
filetype plugin indent on        " language dependent indenting

let g:is_posix=1                 " posix sh highlighting
let b:ruby_no_expensive=1        " expensive ruby highlighting segfaults vim


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
set wildignore+=*.o
set wildignore+=*.pyc
set wildignore+=*.png
set wildignore+=*.jpg
set wildignore+=*.gif

autocmd InsertLeave * set nocursorline " no cursorline in normal mode
autocmd InsertEnter * set cursorline   " cursorline in insert mode
autocmd FileType help wincmd L         " Open help window in vertical split
" Kill manual key:
nnoremap K <nop>

" Saner timeouts:
set notimeout
set ttimeout
set ttimeoutlen=10

" Allow changing from unsaved buffer:
set hidden

" Saner <C-A>/<C-X> incr/decr:
set nrformats-=octal


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

set scrolloff=3   " Keep margin of 3 lines before/after cursor when scrolling.

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
set wrap           " visually wrap lines longer than the window
set colorcolumn=80 " mark lines over 80 columns
set linebreak      " wrap lines on word boundaries
silent! set breakindent " wrap lines with indent
set autoindent     " fallback when filetype don't provide indent

set expandtab      " expand tabs to spaces
set tabstop=2      " width of an actual tab char in spaces
set softtabstop=2  " width of an inserted tab char
set shiftwidth=2   " number of spaces for each indent
set shiftround     " snap to indent columns
set smarttab       " inserts spaces according to shiftwidt when <TAB>

au FileType python setl softtabstop=4 tabstop=4 shiftwidth=4

function Tabs()
  setl noexpandtab softtabstop=0 tabstop=4 shiftwidth=4 nosmarttab
endfunction

command! Tabs :call Tabs()

au BufRead APKBUILD call Tabs()
au BufRead template call Tabs()
au BufRead template setl ft=sh
au BufRead update setl ft=sh
au FileType c,cpp,go call Tabs()
au FileType lua call Tabs()
au FileType sh call Tabs()
au BufRead Config.in setl ft=kconfig


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle indent based folding (defaults to off) with 'zi':
set foldmethod=indent
set foldnestmax=3
set nofoldenable


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
nnoremap <leader>b :ls<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>n :bn<CR>
nnoremap <leader>d :bd<CR>
nnoremap <leader>g :b#<CR>
nnoremap <leader>1 :1b<CR>
nnoremap <leader>2 :2b<CR>
nnoremap <leader>3 :3b<CR>
nnoremap <leader>4 :4b<CR>
nnoremap <leader>5 :5b<CR>
nnoremap <leader>6 :6b<CR>
nnoremap <leader>7 :7b<CR>
nnoremap <leader>8 :8b<CR>
nnoremap <leader>9 :9b<CR>
nnoremap <leader>0 :10b<CR>

" Toggle paste mode for no autoindenting:
nnoremap <leader>i :set invpaste<CR>

" Opens an edit command with the path of the current file filled in
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Create vertical split and navigate to it:
nnoremap <leader>w <C-w>v<C-w>l

" Clear search highlights:
nnoremap <leader>c :noh<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

iabbrev @@ eivind@uggedal.com


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
