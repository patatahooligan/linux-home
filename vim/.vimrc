" Load the default settings. Vim would skip them when it finds
" a ~/.vimrc
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" Use 4 spaces for indentation, make tabs = 4 spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Enable line numbering
set number

" Enable rulers at 80, 100, 120 characters
" Should be grey, but maybe that's not true on all pallets. Might have to do
" some tests and reconsider.
set colorcolumn=80,100,120
highlight ColorColumn ctermbg=8 guibg=lightgrey
