function! s:explore() abort
    if exists(':Rexplore') == 2 && exists('w:netrw_rexlocal')
        Rexplore
    else
        Explore
    endif
endfunction

if v:version > 704 || (v:version == 704 && has('patch605'))
    function! s:set_altfile() abort
        if g:netrw_altfile
            let w:vimrc_alt = bufnr('#')
            let @# = bufnr('%')
        endif
    endfunction

    function! s:restore_altfile() abort
        if g:netrw_altfile && exists('w:vimrc_alt')
            if w:vimrc_alt != -1
                let @# = w:vimrc_alt
            endif
            unlet! w:vimrc_alt
        endif
    endfunction
else
    function! s:set_altfile() abort
        " No-op since # register is read-only
    endfunction

    function! s:restore_altfile() abort
        " No-op since # register is read-only
    endfunction
endif

" v162b and v162d fix issues with overwriting plus register
if g:loaded_netrwPlugin >=# 'v162d'
    function! netrw_helper#quit(isLocal) abort
        if exists('w:netrw_rexlocal')
            Rexplore

            call s:restore_altfile()
        else
            bdelete
        endif
    endfunction

    function! netrw_helper#explore() abort
        call s:set_altfile()

        call s:explore()
    endfunction
else
    if v:version > 704 || (v:version == 704 && has('patch242'))
        function! s:save_reg() abort
            if has('clipboard')
                let s:saved_star = [getreg('*', 1, 1), getregtype('*')]
                let s:saved_plus = [getreg('+', 1, 1), getregtype('+')]
            endif
        endfunction
    else
        function! s:save_reg() abort
            if has('clipboard')
                let s:saved_star = [getreg('*', 1), getregtype('*')]
                let s:saved_plus = [getreg('+', 1), getregtype('+')]
            endif
        endfunction
    endif

    function! s:restore_reg() abort
        if has('clipboard')
            call setreg('*', s:saved_star[0], s:saved_star[1])
            call setreg('+', s:saved_plus[0], s:saved_plus[1])
        endif
    endfunction

    function! netrw_helper#quit(isLocal) abort
        if exists('w:netrw_rexlocal')
            call s:save_reg()

            Rexplore

            call s:restore_reg()

            call s:restore_altfile()
        else
            bdelete
        endif
    endfunction

    function! netrw_helper#explore() abort
        call s:set_altfile()

        call s:save_reg()

        call s:explore()

        call s:restore_reg()
    endfunction
endif
