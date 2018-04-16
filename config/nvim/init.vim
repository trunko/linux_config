filetype off

" Set the runtime path to include Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Lets Vundle manage itself
Plugin 'VundleVim/Vundle.vim'

" Cosmetic
Plugin 'itchyny/lightline.vim'
"Plugin 'yggdroot/indentline'

" Syntax
Plugin 'pangloss/vim-javascript'
Plugin 'rust-lang/rust.vim'
Plugin 'tpope/vim-markdown'

" Autocomplete
"Plugin 'Valloric/YouCompleteMe'

" Git
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" Use cs"' to change "hello" to 'hello'
Plugin 'tpope/vim-surround'

" Use gcc to comment a line
Plugin 'tpope/vim-commentary'

" Use :Tab /= to align on the = character
Plugin 'godlygeek/tabular'

" Auto inserts a pair to parenthesis, brackets, etc.
Plugin 'jiangmiao/auto-pairs'

" Paint css colors with the real color
Plugin 'lilydjwg/colorizer'

" Linting
Plugin 'vim-syntastic/syntastic'

call vundle#end()

filetype plugin indent on

syntax on
set hidden

set wildmenu
set wildmode=list:longest

set showcmd
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set mouse=a
set number

set encoding=utf-8
set t_Co=256
set nowrap

set noshowmode

set noswapfile
set nobackup

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set nohlsearch
set incsearch
set ignorecase
set smartcase
set infercase

set scrolloff=10

set termguicolors

nnoremap Y y$

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
