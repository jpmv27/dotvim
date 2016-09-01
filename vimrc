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
set encoding=utf-8
set listchars=tab:▶▷,eol:⏎,trail:␠,nbsp:⎵,extends:⇨,precedes:⇨

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
set cinoptions=g0,(0,u0,U0
set formatoptions=vtcrq
filetype plugin indent on

" Spelling
set spell spelllang=en_ca
set spellfile=~/.vim/spell/en.utf-8.add
let g:pps_common_spellfile='~/.vim/spell/en.utf-8.add'

" Colours and highlighting
if has('gui_running')
    colorscheme elflord
endif
set background=dark
highlight SpellBad ctermfg=0
highlight SpellCap ctermfg=0
highlight SpellRare ctermfg=0
highlight SpellLocal ctermfg=0
let g:load_doxygen_syntax=1
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

" Custom commands
command! -nargs=0 LcdHere lcd %:p:h

" Configure Netrw
let g:netrw_sort_sequence='[\/]$,*,^[.]'
let g:netrw_sort_options='i'
let g:netrw_list_hide='\.swp$,\.o$,\.so$'
let g:netrw_altfile=1

" Initialize Pathogen
execute pathogen#infect()

" Configure Vim-project
let g:project_enable_welcome=0
let g:project_enable_win_title=0
let g:project_enable_tab_title_gui=1
let g:project_enable_tab_title_term=1

" Configure Vim-man
nmap <silent> <leader>man <Plug>(Man)

" Configure Tagbar
let g:tagbar_case_insensitive=1
let g:tagbar_autofocus=1
nmap <silent> <leader>tb :TagbarToggle<CR>

" Local customizations go into vimrc.local in same directory as vimrc (this script)
" (from https://stackoverflow.com/a/18734557)
let s:vimrc_local = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/vimrc.local'
if filereadable(s:vimrc_local)
    exec 'source' s:vimrc_local
endif

