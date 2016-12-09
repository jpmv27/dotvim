function! s:explore() abort
    if exists(':Rexplore') == 2 && exists('w:netrw_rexlocal')
        Rexplore
    else
        Explore
    endif
endfunction

function! s:set_altfile() abort
    if g:netrw_altfile
        let w:vimrc_alt = bufnr('#')
        let @# = bufnr('%')
    endif
endfunction

function! s:restore_altfile() abort
    if g:netrw_altfile && exists('w:vimrc_alt')
        let @# = w:vimrc_alt
        unlet! w:vimrc_alt
    endif
endfunction

" v162b and v162d fix issues with overwriting plus register
if g:loaded_netrwPlugin >=# 'v162d'
    function! netrw_helper#quit(isLocal) abort
        Rexplore

        call s:restore_altfile()
    endfunction

    function! netrw_helper#explore() abort
        call s:set_altfile()

        call s:explore()
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

        call s:restore_altfile()
    endfunction

    function! netrw_helper#explore() abort
        call s:set_altfile()

        call s:save_reg()

        call s:explore()

        call s:restore_reg()
    endfunction
endif
