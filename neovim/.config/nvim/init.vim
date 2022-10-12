set termguicolors

" Enable rulers at 72, 80, 100, 120 characters Most of the time I use a
" width of 80 characters, but depending on the context I want to have
" the rest available as well. Should be grey, but maybe that's not true
" on all pallets. Might have to do some tests and reconsider.
set colorcolumn=72,80,100,120

" It seems that neovim exhibits slightly different behavior to vim
" regarding colorschemes. If you set a colorscheme, trying to set other
" highlight properties fails. I'm guessing it's some sort of priority
" system. This command essentially sets a hook that sets the highlight
" color everytime you load a colorscheme, and this successfully
" overrides the colorscheme. Since I don't unset the autocmd, it should
" mean that the rulers remain the same color even if a load another
" colorscheme. I haven't really tried the gui color (I don't use one). I
" picked one that is probably close and I'll adjust it if it ever
" becomes relevant.
autocmd ColorScheme * highlight ColorColumn ctermbg=235 guibg=#303030
autocmd ColorScheme * highlight Whitespace ctermfg=8 guifg=#75715E
autocmd ColorScheme * highlight NonText ctermfg=3
autocmd ColorScheme * highlight LineNr ctermfg=250 ctermbg=234 guifg=#BCBC00 guibg=#3B3A32
autocmd ColorScheme * highlight LineNrAbove ctermfg=250 ctermbg=234 guifg=#BCBCBC guibg=#3B3A32
autocmd ColorScheme * highlight link LineNrBelow LineNrAbove

" "Restore" the cursor style. neovim has no way to know what state it's
" supposed to leave it in. If I change what I set it to in the terminal
" configuration, this has to also be changed to reflect it...
au VimLeave,VimSuspend * set guicursor=a:ver100-blinkon0

let g:molokai_original = 1
colorscheme molokai

" Set leader key. Do this first to make sure no mappings are registered
" with the default value.
let mapleader = " "
let maplocalleader = " "

" Load plugins
packloadall
silent! helptags ALL

" Use 4 spaces for indentation, make tabs = 4 spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Set linue numbering to hybrid: the current line gets its absolute
" number to use as a reference, but the rest get relative numbers to
" assist in navigation.
set number relativenumber

" Not sure if this should always be on, but try it out for now. The
" wrapping makes a lot of code I work on unreadable. Set textwidth which
" will be used when writing text and comments.
set nowrap
set textwidth=72

" ctags shortcut for autocompletion
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Enable always on status bar
set laststatus=2

" Disable mouse because it causes some issues, especially concerning
" clipboard integration with the rest of the system. Maybe I can
" selectively enable it for some modes without causing issues, but I'm
" not sure if I want to. Leave it fully off for now and potentially
" change it later.
set mouse=

" Highlight potentially unwanted characters such as tabs and trailing
" spaces
:set listchars=tab:\ ->,trail:·,extends:>,precedes:<
:set list

" Reduce update time. Apparently this can affect the update time of
" plugins as well, like gitgutter, so we need it to be relatively low.
" But at the same time it affects drive I/O (swap file saving) so let's
" not go too low.
set updatetime=500

execute 'source' . stdpath('config') . '/lsp.lua'

" Experimental configuration for neovide
set guifont=FiraCode\ Nerd\ Font:h14
if exists("g:neovide")
    " TODO: figure out if I can get this to match to the monitor somehow
    let g:neovide_refresh_rate = 144
    let g:neovide_cursor_animation_length=0.03
    let g:neovide_hide_mouse_when_typing = v:true
endif
