" Buffer management
set autowriteall
set hidden
set switchbuf=useopen

" Display
set textwidth=100
set colorcolumn=+1
set showtabline=2
set laststatus=2
set statusline=%{fugitive#statusline()}\ %f\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%v(%c),%l/%L\ %P
set title

" Search
set ignorecase
set incsearch
set nohlsearch

" Formatting
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=-1
set cindent
set formatoptions=vtcrq
filetype plugin indent on

" Spelling
set spell spelllang=en_ca

" Colours and highlighting
if !has('gui_running')
    set background=dark
endif
highlight SpellBad ctermfg=0
highlight SpellCap ctermfg=0
highlight SpellRare ctermfg=0
highlight SpellLocal ctermfg=0
syntax on

" Miscellaneous
set showmatch
set backspace=indent,eol,start
set wildmode=longest,list:longest
set mouse=a
if has('unnamedplus')
    set clipboard=unnamedplus,autoselect,exclude:cons\|linux
elseif has('clipboard')
    set clipboard=unnamed,autoselect,exclude:cons\|linux
endif

" Initialize Pathogen
execute pathogen#infect()

" Local customizations go into vimrc.local in same directory as vimrc (this script)
" (from https://stackoverflow.com/a/18734557)
let s:vimrc_local = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/vimrc.local'
if filereadable(s:vimrc_local)
    exec 'source' s:vimrc_local
endif

