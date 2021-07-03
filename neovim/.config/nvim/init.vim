let g:molokai_original = 1
colorscheme molokai
" Prevent buggy erasing of the background when scrolling
set t_ut=""

" Set leader key. Do this first to make sure no mappings are registered with
" the default value.
let mapleader = " "
let maplocalleader = " "

" Load plugins
packloadall
silent! helptags ALL

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
highlight ColorColumn ctermbg=234 guibg=lightgrey

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

" Highlight potentially unwanted characters such as tabs and trailing spaces
:set listchars=tab:\ ->,trail:·,extends:>,precedes:<
:set list

" Enable rust analyzer
lua << EOF
require'lspconfig'.rust_analyzer.setup{}
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
EOF
