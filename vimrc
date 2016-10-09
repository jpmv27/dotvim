set encoding=utf-8
scriptencoding utf-8

" Buffer management
set autowriteall
set hidden
set switchbuf=usetab

" Display
set textwidth=100
set colorcolumn=+1
set showtabline=2
set laststatus=2
set statusline=%{fugitive#statusline()}\ %f\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y\ %#ErrorMsg#%{SyntasticStatuslineFlag()}%{CleanModeStatus()}%*\ %=%v(%c),%l/%L\ %P
set listchars=tab:▶▷,eol:⏎,trail:␠,nbsp:⎵,extends:⇨,precedes:⇨

" Search
set ignorecase
set smartcase
set incsearch
set nohlsearch

" Formatting
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=-1
set formatoptions=vtcrq
filetype plugin indent on
augroup martin
    autocmd!
    autocmd BufWinEnter * normal zR
augroup END

" Spelling
set spell
set spelllang=en_ca
set spellfile=~/.vim/spell/en.utf-8.add

" Colours and highlighting
if has('gui_running')
    colorscheme elflord
endif
set background=dark
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

" Custom commands
command! -nargs=0 LcdHere lcd %:p:h
command! -nargs=0 Terminal ConqueTermSplit bash

" Configure "clean" mode
nmap <silent> <leader>cm :ToggleCleanMode<cr>

" Configure Netrw
let g:netrw_sort_sequence='[\/]$,*,^[.]'
let g:netrw_sort_options='i'
let g:netrw_list_hide='\.swp$,\.o$,\.so$'
let g:netrw_altfile=1
let g:netrw_preview=1
nmap <silent> <leader>ex :Explore<CR>

" Initialize Pathogen
execute pathogen#infect()

" Configure BufExplorer
let g:bufExplorerShowTabBuffer=1
let g:bufExplorerOnlyOneTab=1

" Configure Vim-project
let g:project_enable_welcome=0
let g:project_enable_win_title=0
let g:project_enable_tab_title_gui=1
let g:project_enable_tab_title_term=1
nmap <silent> <leader>we :Welcome<CR>
nmap <silent> <leader>wt :TabWelcome<CR>

" Configure vim-per-project-settings
call pps#init('~/.per_project_settings')

" Configure Vim-man
nmap <silent> <leader>man <Plug>(Man)

" Configure Tagbar
let g:tagbar_sort=0
let g:tagbar_case_insensitive=1
nmap <silent> <leader>tb :TagbarToggle<CR>
nmap <silent> <leader>to :TagbarOpen fj<CR>

" Configure vim-autoformat
let g:formatters_c=['astyle_c']
let g:formatdef_astyle_c='"astyle --mode=c --suffix=none --options=~/.vim/astyle/c.astylerc"'
let g:formatters_cpp=['astyle_cpp']
let g:formatdef_astyle_cpp='"astyle --mode=c --suffix=none --options=~/.vim/astyle/cpp.astylerc"'

" Configure Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_c_compiler_options=''
let g:syntastic_c_no_default_include_dirs=1
let g:syntastic_cpp_compiler_options=''
let g:syntastic_cpp_no_default_include_dirs=1
let g:syntastic_vim_checkers=['vint']

" Configure Ctrlp
let g:ctrlp_working_path_mode = ''
let g:ctrlp_match_window = 'results:100'

" Configure Conque-Shell
let g:ConqueTerm_StartMessages=0
let g:ConqueTerm_CloseOnEnd=1

" Configure vim-easygrep
let g:EasyGrepCommand=1
let g:EasyGrepMode=2
let g:EasyGrepWindow=1
let g:EasyGrepSearchCurrentBufferDir=0
let g:EasyGrepAllOptionsInExplorer=1
let g:EasyGrepRecursive=1
let g:EasyGrepFilesToExclude='*.swp,*~,*.map,*.d'
let g:EasyGrepDirsToExclude='.svn,.git'

" Local customizations go into vimrc.local in same directory as vimrc (this script)
" (from https://stackoverflow.com/a/18734557)
let s:vimrc_local = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/vimrc.local'
if filereadable(s:vimrc_local)
    exec 'source' s:vimrc_local
endif

