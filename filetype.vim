augroup MyFiletypes

" Log files
au BufNewFile,BufRead *.log,*.log.*            setf logfile

" JavaScript modules
au BufNewFile,BufRead *.jsm                    setf javascript

augroup END
