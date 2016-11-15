" v162b and v162d fix issues with overwriting plus register
if g:loaded_netrwPlugin >=# 'v162d'
    function! netrw_helper#quit(isLocal) abort
        Rexplore

        if g:netrw_altfile
            let @# = w:vimrc_alt
            unlet! w:vimrc_alt
        endif
    endfunction

    function! netrw_helper#explore() abort
        if g:netrw_altfile
            let w:vimrc_alt = bufnr('#')
            let @# = bufnr('%')
        endif

        if exists(':Rexplore') == 2 && exists('w:netrw_rexlocal')
            Rexplore
        else
            Explore
        endif
    endfunction
else
    function! s:save_reg() abort
        if has('clipboard')
            let s:saved_star = [getreg('*', 1, 1), getregtype('*')]
            let s:saved_plus = [getreg('+', 1, 1), getregtype('+')]
        endif
    endfunction

    function! s:restore_reg() abort
        if has('clipboard')
            call setreg('*', s:saved_star[0], s:saved_star[1])
            call setreg('+', s:saved_plus[0], s:saved_plus[1])
        endif
    endfunction

    function! netrw_helper#quit(isLocal) abort
        call s:save_reg()

        Rexplore

        call s:restore_reg()

        if g:netrw_altfile
            let @# = w:vimrc_alt
            unlet! w:vimrc_alt
        endif
    endfunction

    function! netrw_helper#explore() abort
        if g:netrw_altfile
            let w:vimrc_alt = bufnr('#')
            let @# = bufnr('%')
        endif

        call s:save_reg()

        if exists(':Rexplore') == 2 && exists('w:netrw_rexlocal')
            Rexplore
        else
            Explore
        endif

        call s:restore_reg()
    endfunction
endif
