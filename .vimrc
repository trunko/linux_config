set nocompatible
filetype off
set hidden

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Bundle 'yonchu/accelerated-smooth-scroll'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'

call vundle#end()

filetype on
filetype plugin on
filetype indent on

set encoding=utf-8
set t_Co=256

syntax on

set number
set ruler

set showcmd
set mouse=a

set noshowmode

set noswapfile
set nobackup

set hidden
set autoread
set wrap
set nostartofline
set wildmenu
set confirm
set visualbell
set t_vb=
set laststatus=2

set softtabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start

set nohlsearch
set incsearch
set showmatch
set ignorecase
set smartcase
set gdefault

nnoremap <CR> :nohlsearch<cr>
nnoremap <Space> za
nnoremap B ^
nnoremap E $
nnoremap $ <nop>
nnoremap ^ <nop>

map Y y$

let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']],
  \   'right': [['percent'], ['lineinfo']],
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ },
  \}
