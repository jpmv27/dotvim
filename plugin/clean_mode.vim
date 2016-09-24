" Clean-up distractions

function! s:GoToWindow(nr)
    execute a:nr . 'wincmd w'
endfunction

function! s:EnableCleanSettings() abort
    if !exists('b:clean_saved_spell')
        let b:clean_saved_spell = &spell
        setlocal nospell
    endif

    if !exists('b:clean_saved_cc')
        let b:clean_saved_cc = &cc
        setlocal cc=
    endif

    if !exists('b:clean_saved_bws') && exists('b:better_whitespace_enabled')
        let b:clean_saved_bws = b:better_whitespace_enabled
        silent execute "normal! :DisableWhitespace\<cr>"
    endif

    if !exists('b:clean_saved_syntastic')
        let b:clean_saved_syntastic = get(g:, 'syntastic_check_on_open', 0) && !get(b:, 'syntastic_skip_checks', 0)
        silent execute "normal! :SyntasticReset\<cr>"
    endif
endfunction

function! s:RestorePreviousSettings() abort
    if exists('b:clean_saved_spell')
        if b:clean_saved_spell
            setlocal spell
        endif
        unlet b:clean_saved_spell
    endif

    if exists('b:clean_saved_cc')
        execute 'setlocal cc=' . b:clean_saved_cc
        unlet b:clean_saved_cc
    endif

    if exists('b:clean_saved_bws')
        if b:clean_saved_bws
            silent execute "normal! :EnableWhitespace\<cr>"
        endif
        unlet b:clean_saved_bws
    endif

    if exists('b:clean_saved_syntastic')
        if b:clean_saved_syntastic
            silent execute "normal! :SyntasticCheck\<cr>"
        endif
        unlet b:clean_saved_syntastic
    endif
endfunction

function! s:ApplyCleanMode() abort
    if !&modifiable
        return
    endif

    if !exists('t:clean_mode')
        call s:RestorePreviousSettings()
    else
        call s:EnableCleanSettings()
    endif
endfunction

function! s:ToggleCleanMode() abort
    let sw = winnr()

    if !exists('t:clean_mode')
        let t:clean_mode = ''
    else
        unlet t:clean_mode
    endif

    for wn in range(1, winnr('$'))
        call s:GoToWindow(wn)
        call s:ApplyCleanMode()
    endfor

    call s:GoToWindow(sw)
endfunction

function! CleanModeStatus() abort
    return (exists('t:clean_mode') && &modifiable) ? '[CLEAN]' : ''
endfunction

command! -nargs=0 ToggleCleanMode call s:ToggleCleanMode()

augroup clean_mode
    autocmd!
    autocmd BufEnter * call s:ApplyCleanMode()
augroup END

