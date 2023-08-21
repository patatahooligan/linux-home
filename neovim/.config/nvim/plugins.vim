call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-orgmode/orgmode'

call plug#end()

let g:coc_global_extensions = [
            \ 'coc-clangd',
            \ 'coc-cmake',
            \ 'coc-css',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-markdown-preview-enhanced',
            \ 'coc-pyright',
            \ 'coc-rust-analyzer',
            \ 'coc-tsserver',
            \ 'coc-webview'
            \ ]

execute 'source' . stdpath('config') . '/coc-config.vim'
execute 'source' . stdpath('config') . '/treesitter-init.lua'
