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

set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start

set nohlsearch
set incsearch
set showmatch
set ignorecase
set smartcase
set gdefault

au FileType {make,gitconfig,go} setl noexpandtab

au BufNewFile,BufRead *.json setf javascript

au FileType python setl softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

:nnoremap <CR> :nohlsearch<cr>

:nnoremap <Space> za

nnoremap B ^
nnoremap E $
nnoremap $ <nop>
nnoremap ^ <nop>

map <leader>y "*y

nmap <leader>p pV` ]=
nmap <leader>P PV` ]=

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
