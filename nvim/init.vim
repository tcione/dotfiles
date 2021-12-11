" ---
" Hey! Welcome to my personal neovim config.
" Please, feel at home and take whatever you see fit :D
"
" =========================================
" TODOs
" =========================================
" . Learn more about vim-fugitive
" - Reconsider if nvim-cmp is worth the performance tax
" - Introduce goyo or zen-mode to ProseMode
" - Probably do some plugin cleanup
" x Make lua scripting consistent
" x Consider separating lua config and sourcing its parts later
" x Make lua requires silently fail when the plugin is not yet installed
" x Verify if still needs 'sheerun/vim-polyglot'
" x Consider installing 'nvim-treesitter/playground'
" x Consider installing editorconfig
" x Think of a way to run TSInstall automatically

" =========================================
" Environment setup
" =========================================

let $NVIM_CONFIG_DIR = expand('$HOME/.config/nvim')
let $NVIM_SITE_DIR = expand('$HOME/.local/share/nvim/site')
let $NVIM_PLUGINS_DIR = expand('$NVIM_SITE_DIR/plugged')

set runtimepath^=$NVIM_CONFIG_DIR
set runtimepath+=$NVIM_CONFIG_DIR/after
set runtimepath+=$NVIM_SITE_DIR
set runtimepath+=$NVIM_SITE_DIR/after
set runtimepath+=$NVIM_SITE_DIR/autoload

" =========================================
" Plugins installation
" =========================================

" Automatically install vim-plug
let $NVIM_VIM_PLUG = expand('$NVIM_SITE_DIR/autoload/plug.vim')
if empty(glob($NVIM_VIM_PLUG))
  silent execute expand('!curl -fLo $NVIM_VIM_PLUG --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin($NVIM_PLUGINS_DIR)

" Dependencies
Plug 'nvim-lua/plenary.nvim' " nvim-telescope/telescope.nvim

" Plugins
Plug 'editorconfig/editorconfig-vim'
Plug 'folke/lsp-colors.nvim'
Plug 'folke/trouble.nvim'
Plug 'janko-m/vim-test'
Plug 'jremmen/vim-ripgrep'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'sainnhe/sonokai'
Plug 'scrooloose/nerdcommenter'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/BufOnly.vim'
Plug 'vim-scripts/PreserveNoEOL'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" Extensions
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'rafamadriz/friendly-snippets'
Plug 'xiyaowong/telescope-emoji.nvim'

call plug#end()

" =========================================
" Functions
" =========================================
function! DeleteTrailingWhiteSpace()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

function! ProseMode()
  set syntax=markdown
  set spell noci nosi noai nolist noshowmode noshowcmd
  set complete+=s
endfunction

" =========================================
" Settings
" =========================================
let mapleader = ","
let g:mapleader = ","
let maplocalleader = "\\"

let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_enable_italic = 1
let g:sonokai_style = 'espresso'
let g:test#strategy = 'neovim'
let g:test#neovim#start_normal = 1
let g:Hexokinase_highlighters = ['backgroundfull']
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:rg_command = 'rg --vimgrep -S'

colorscheme sonokai
filetype plugin indent on

highlight! link rubyModuleName Blue
highlight! link rubySymbol Blue

set exrc
set guicursor=
set relativenumber
set hidden
set number
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set autoindent
set smartindent
set wrap
set wrapmargin=2
set noerrorbells
set novisualbell
set colorcolumn=80
set signcolumn=yes
set termguicolors
set autoread
set clipboard=unnamedplus
set noshowcmd
set encoding=utf8
set ffs=unix,dos,mac
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set hlsearch
set showmatch
set timeoutlen=500
set synmaxcol=1000
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
set list
set breakindent
set breakindentopt=shift:2,min:40,sbr
set linebreak
set shada^=%
set completeopt=menu,menuone,noselect

" =========================================
" Mappings
" =========================================
nmap <leader>w :w!<cr>
map 0 ^
map <space> /
map <c-space> ?
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap <leader>sv :source $MYVIMRC<CR>

noremap <C-w>m :MaximizerToggle<CR>

nnoremap <leader>p <cmd>Telescope find_files<cr>
nnoremap ; <cmd>Telescope buffers<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fe <cmd>Telescope emoji<cr>

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" =========================================
" Initialization commands
" =========================================
augroup tcione
  autocmd!
  autocmd BufWrite * :call DeleteTrailingWhiteSpace()
  " Return to last edit position when opening files
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END

" =========================================
" On-demand commands
" =========================================
command! ProseMode call ProseMode()

" ========================================
" Lua scripting / config
" ========================================
lua require('setup')
