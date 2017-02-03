function! s:LoclistNumber() abort
    redir => list
    silent execute 'lhistory'
    redir END

    if list ==? 'No entries'
        return 0
    endif

    return (index(map(split(list, '\n'), 'v:val[0] ==# ">"'), 1) + 1)
endfunction

function! s:ScheduleSyntasticHelper() abort
    if !&modifiable
        return
    endif

    " Run helper as soon as possible after vim needs input
    call timer_start(1, 'syntastic_helper#run')
endfunction

function! syntastic_helper#run(timer) abort
    let before = s:LoclistNumber()

    SyntasticCheck

    let after = s:LoclistNumber()
    if after < before
        execute 'lnewer ' . (before - after)
    elseif after > before && before != 0
        execute 'lolder ' . (after - before)
    endif
endfunction

function! syntastic_helper#enable() abort
    if exists('*timer_start')
        augroup syntastic_helper_sched
            autocmd!
            autocmd BufReadPost * call s:ScheduleSyntasticHelper()
        augroup END
    else
        let g:syntastic_check_on_open = 1
    endif
endfunction
