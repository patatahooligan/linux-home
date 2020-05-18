" Load the default settings. Vim would skip them when it finds
" a ~/.vimrc
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" Use 4 spaces for indentation, make tabs = 4 spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Enable line numbering
set number

" Enable rulers at 72, 80, 100, 120 characters
" Most of the time I use a width of 80 characters, but depending on the
" context I want to have the rest available as well. Should be grey, but maybe
" that's not true on all pallets. Might have to do some tests and reconsider.
set colorcolumn=72,80,100,120
highlight ColorColumn ctermbg=8 guibg=lightgrey
