call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

call plug#end()

let g:coc_global_extensions = [ 'coc-css', 'coc-html', 'coc-json' ]
