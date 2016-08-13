" Initialise Pathogen
execute pathogen#infect()

" Local customizations go into ~/.vim/vimrc.local
if filereadable($HOME . ".vim/vimrc.local")
    source $HOME/.vim/vimrc.local
endif

