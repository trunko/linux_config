filetype off

" Set the runtime path to include Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Lets Vundle manage itself
Plugin 'VundleVim/Vundle.vim'

" Cosmetic
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airling/vim-airline-themes'
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

" Sets colorscheme
set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
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

" Hide tildes
hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

" Configure Airline
let g:airline_detect_paste=1
let g:airline_powerline_fonts=1

let g:airline_theme='gruvbox'
