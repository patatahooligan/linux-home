" Load the default settings. Vim would skip them when it finds
" a ~/.vimrc
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" Use 4 spaces for indentation, make tabs = 4 spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Enable line numbering
set number
