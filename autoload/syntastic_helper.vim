function! s:RunSyntastic() abort
    call setloclist(0, [])

    SyntasticCheck

    lolder

    augroup syntastic_helper_run
        autocmd!
    augroup END
endfunction

function! s:ScheduleSyntastic() abort
    if !&modifiable
        return
    endif

    augroup syntastic_helper_run
        autocmd!
        autocmd CursorHold <buffer> call s:RunSyntastic()
    augroup END
endfunction

function! syntastic_helper#init() abort
    augroup syntastic_helper_sched
        autocmd!
        autocmd BufReadPost * call s:ScheduleSyntastic()
    augroup END
endfunction
