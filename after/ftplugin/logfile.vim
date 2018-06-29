function! s:set_wrapscan() abort
    if &filetype ==? 'logfile'
        set nowrapscan
    else
        set wrapscan
    endif
endfunction

augroup ftplugin_logfile
    autocmd!
    autocmd BufEnter * call s:set_wrapscan()
augroup END

set nowrapscan
