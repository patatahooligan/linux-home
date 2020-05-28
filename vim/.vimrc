" Load the default settings. Vim would skip them when it finds
" a ~/.vimrc
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" Use 4 spaces for indentation, make tabs = 4 spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Set linue numbering to hybrid: the current line gets its absolute number to
" use as a reference, but the rest get relative numbers to assist in
" navigation.
set number relativenumber

" Enable rulers at 72, 80, 100, 120 characters
" Most of the time I use a width of 80 characters, but depending on the
" context I want to have the rest available as well. Should be grey, but maybe
" that's not true on all pallets. Might have to do some tests and reconsider.
set colorcolumn=72,80,100,120
highlight ColorColumn ctermbg=8 guibg=lightgrey

" Not sure if this should always be on, but try it out for now. The wrapping
" makes a lot of code I work on unreadable.
set nowrap

" ctags shortcut for autocompletion
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Enable always on status bar
set laststatus=2

" Disable mouse because it causes some issues, especially concerning clipboard
" integration with the rest of the system. Maybe I can selectively enable it
" for some modes without causing issues, but I'm not sure if I want to. Leave
" it fully off for now and potentially change it later.
set mouse=
