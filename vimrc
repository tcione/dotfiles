"""""""""""""""""""""""""""""""""""""
" Minimal vim config, since I've migrated
" fully to neovim
""""""""""""""""""""""""""""""""""""""

" Remap leader for nice combos
let mapleader = ","
let g:mapleader = ","
let maplocalleader = "\\"
let base16colorspace=256

filetype off
syntax enable
colorscheme monokai

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

set termguicolors
set nocompatible
set maxmempattern=5000
set history=700
set autoread
set clipboard=unnamed
set t_Co=256
set termguicolors
set noruler
set noshowcmd
set encoding=utf8
set ffs=unix,dos,mac
set nobackup
set nowb
set noswapfile
set number
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set hlsearch
set showmatch
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set synmaxcol=1000
set laststatus=2
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
set list
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set wrap
set breakindent
set breakindentopt=shift:2,min:40,sbr
set linebreak
set tw=1000
set wm=2
set viminfo^=%

nmap <leader>w :w!<cr>
map 0 ^
map <space> /
map <c-space> ?
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <C-k><C-b> :Explore<cr>
map - :Explore<cr>
map <leader>fi g=GG
map <leader>cd :cd %:p:h<cr>:pwd<cr>
