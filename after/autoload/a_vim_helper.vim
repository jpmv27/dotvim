function! a_vim_helper#force() abort
    let saved = g:alternateNoDefaultAlternate
    let g:alternateNoDefaultAlternate = 0
    A
    let g:alternateNoDefaultAlternate = saved
endfunction
