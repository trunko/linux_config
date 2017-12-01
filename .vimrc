set t_Co=256
set nocompatible
set encoding=utf-8

filetype on
filetype plugin on
filetype indent on

syntax on

set number
set ruler
set showcmd
set mouse=a
set noswapfile
set hidden
set wrap
set linebreak
set breakindent
set breakindentopt=min:40

set tabstop=4
set shiftwidth=2
set expandtab
set shiftround
set backspace=indent,eol,start

set hlsearch
set incsearch
set ignorecase
set smartcase
set gdefault

au FileType {make,gitconfig,go} setl noexpandtab

au BufNewFile,BufRead *.json setf javascript

au FileType python setl softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

:nnoremap <CR> :nohlsearch<cr>

:nnoremap <Space> za

map <leader>y "*y

nmap <leader>p pV` ]=
nmap <leader>P PV` ]=

set noshowmode
