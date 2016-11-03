set encoding=utf-8
scriptencoding utf-8

" When jumping from location bar across tabs, spurious E924 generated
let s:use_loclist = has('E924fix') || has('patch-8.0.37')

" Buffer management
set autowriteall
set hidden
set switchbuf=usetab

" Display
set colorcolumn=101
set showtabline=2
set laststatus=2
set statusline=%{fugitive#statusline()}\ %f\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y\ %#ErrorMsg#%{SyntasticStatuslineFlag()}%{clean_mode#status()}%*\ %=%v(%c),%l/%L\ %P
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
augroup vimrc_unfold
    autocmd!
    autocmd BufWinEnter * normal zR
augroup END

" Spelling
set spell
set spelllang=en_ca
set spellfile=~/.vim/spell/en.utf-8.add

" Completion
set completeopt=menu,menuone,noinsert

" Colours and highlighting
if has('gui_running')
    colorscheme elflord
endif
set background=dark
highlight SpellBad ctermfg=0
highlight SpellCap ctermfg=0
highlight SpellRare ctermfg=0
highlight SpellLocal ctermfg=0
" vim-cpp-enhanced-highlight
highlight link cAnsiFunction Keyword
highlight link cAnsiName Keyword
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

" Configure Netrw
let g:netrw_sort_sequence = '[\/]$,*,^[.]'
let g:netrw_sort_options = 'i'
let g:netrw_list_hide = '\.swp$,\.o$,\.so$'
let g:netrw_altfile = 1
let g:netrw_preview = 1
let g:Netrw_UserMaps = [['Q', 'VimrcNetrwQuit']]
function! VimrcNetrwQuit(isLocal) abort
    Rexplore

    try
        let @# = w:vimrc_alt
        unlet! w:vimrc_alt
    catch
    endtry
endfunction
function! VimrcNetrwExplore() abort
    try
        let w:vimrc_alt = bufnr('#')
        let @# = bufnr('%')
    catch
    endtry

    if exists(':Rexplore')
        Rexplore
    else
        Explore
    endif
endfunction
nmap <silent> <leader>ex :call VimrcNetrwExplore()<CR>

" Initialize Pathogen
execute pathogen#infect()

" Configure BufExplorer
let g:bufExplorerShowTabBuffer = 1
let g:bufExplorerOnlyOneTab = 1

" Configure Vim-project
let g:project_enable_welcome = 0
let g:project_enable_win_title = 0
let g:project_enable_tab_title_gui = 1
let g:project_enable_tab_title_term = 1
nmap <silent> <leader>we :Welcome<CR>
nmap <silent> <leader>wt :TabWelcome<CR>

" Configure vim-per-project-settings
call pps#init('~/.per_project_settings')

" Configure Vim-man
nmap <silent> <leader>lu <Plug>(Man)

" Configure Tagbar
let g:tagbar_sort = 0
let g:tagbar_case_insensitive = 1
nmap <silent> <leader>tb :TagbarToggle<CR>
nmap <silent> <leader>to :TagbarOpen fj<CR>

" Configure vim-autoformat
let g:autoformat_verbosemode = 1
let g:autoformat_remove_trailing_spaces = 0
let g:autoformat_retab = 0
let g:autoformat_autoindent = 0
let g:formatters_c = ['astyle_c']
let g:formatdef_astyle_c='"astyle --mode=c --suffix=none --options = $HOME/.vim/astyle/c.astylerc"'
let g:formatters_cpp = ['astyle_cpp']
let g:formatdef_astyle_cpp='"astyle --mode=c --suffix=none --options = $HOME/.vim/astyle/cpp.astylerc"'
let g:formatters_java = ['astyle_java']
let g:formatdef_astyle_java='"astyle --mode=java --suffix=none --options = $HOME/.vim/astyle/java.astylerc"'

" Configure Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_reuse_loc_lists = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_c_compiler_options = ''
let g:syntastic_c_no_default_include_dirs = 1
let g:syntastic_cpp_compiler_options = ''
let g:syntastic_cpp_no_default_include_dirs = 1
let g:syntastic_vim_checkers = ['vint']
"call syntastic_helper#init()
command -nargs=0 ErrorsReplace let g:syntastic_reuse_loc_lists = 1 | call SyntasticErrors() | let g:syntastic_reuse_loc_lists = 0

" Configure Ctrlp
let g:ctrlp_working_path_mode = ''
let g:ctrlp_match_window = 'results:100'

" Configure Conque-Shell
let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_CloseOnEnd = 1

" Configure vim-easygrep
if match(system('grep --version'), 'GNU.*2\.10') >= 0
    echo 'GNU grep 2.10 is buggy, vim-easygrep will not work properly'
endif
let g:EasyGrepCommand = 1
let g:EasyGrepMode = 2
if s:use_loclist
    let g:EasyGrepWindow = 1
endif
let g:EasyGrepSearchCurrentBufferDir = 0
let g:EasyGrepAllOptionsInExplorer = 1
let g:EasyGrepRecursive = 1
let g:EasyGrepFilesToExclude = '*.swp,*~,*.map,*.d'
let g:EasyGrepDirsToExclude = '.svn,.git'

" Configure vim-bookmarks
if s:use_loclist
    let g:bookmark_location_list = 1
endif
let g:bookmark_no_default_key_mappings = 1
nmap <silent> <Leader>mm :BookmarkToggle<CR>
nmap <silent> <Leader>mi :BookmarkAnnotate<CR>
nmap <silent> <Leader>ma :BookmarkShowAll<CR>
nmap <silent> <Leader>mn :BookmarkNext<CR>
nmap <silent> <Leader>mp :BookmarkPrev<CR>
nmap <silent> <Leader>mc :BookmarkClear<CR>

" Configure vim-template
let g:templates_no_autocmd = 1
let g:templates_search_height = 0
let g:templates_directory = ['$HOME/.vim-templates', '$HOME/.vim/templates']
let g:templates_user_variables = []

" Local customizations go into vimrc.local in same directory as vimrc (this script)
" (from https://stackoverflow.com/a/18734557)
let s:vimrc_local = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/vimrc.local'
if filereadable(s:vimrc_local)
    exec 'source' s:vimrc_local
endif

" Configure vim-clean-mode (must be the very last thing)
call clean_mode#init()
let g:clean_mode_force += ['conque_term', 'easygrep', 'git', 'help', 'messages', 'project', 'qf', 'tagbar', 'tags']
nmap <silent> <leader>cm :ToggleCleanMode<cr>
nmap <silent> <leader>cd :ToggleDefaultCleanMode<cr>

unlet! s:use_loclist
