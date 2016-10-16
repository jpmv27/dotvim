function! s:RunSyntastic() abort
    let saved_list = getloclist(0)

    SyntasticCheck

    call setloclist(0, saved_list, 'r')

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
