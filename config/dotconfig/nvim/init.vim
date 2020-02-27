set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
call plug#begin('~/.vim/plugged')

"Swiss knife for opening / changing files
Plug 'ctrlpvim/ctrlp.vim'

" Git diff column in the gutter
Plug 'airblade/vim-gitgutter'
Plug 'unblevable/quick-scope'
Plug 'ajmwagar/vim-deus'
"Adds Goyo mode, which hides unnecessary visual clutter temporarily
Plug 'junegunn/goyo.vim'
"IDE-like features
Plug 'neoclide/coc.nvim', {'branch': 'release' }
" Am i using polyglot for anything??
Plug 'sheerun/vim-polyglot'


Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
"Latex support
Plug 'lervag/vimtex'
call plug#end()

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

set encoding=utf-8
set title " Show current file in title
let mapleader = ","
set mouse=a
set linebreak
set backspace=2 " make backspace work like most other programs
set number relativenumber
set laststatus=0
set wildignore+=*/target/*
set shiftwidth=4
set clipboard=unnamedplus
setl conceallevel=0

"Store an undo buffer in a file in $HOME/.vimundo
set undofile
set undolevels=1000
set undoreload=10000

"Hide buffer something
set hidden

"Set deus as colorscheme and some related variables to ensure proper background 
set t_Co=256
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark " Setting dark mode, default in nvim
colorscheme deus
let g:deus_termcolors=256

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Latex configuration
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'

set conceallevel=1
" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
" Remember to set `stty stop undef` in shell
command -nargs=0 -bar Update if &modified 
\    if empty(bufname('%'))
\        browse confirm write
\    else
\        confirm write
\    endif
\endif

nnoremap <silent> <C-S> :<C-u>Update<CR>
noremap <Leader>s :update<CR>
inoremap <silent><expr> <c-space> coc#refresh()
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
autocmd FileType markdown :CocDisable
autocmd FileType markdown set nonumber
autocmd FileType tex set nonumber

autocmd FileType javascript,javascriptreact,typescript,typescriptreact set tabstop=4 shiftwidth=4 expandtab

let g:pandoc#spell#enabled = 0
let g:pandoc#modules#disabled = ["folding"]

let g:goyo_width=140
let g:goyo_height=100

autocmd BufNewFile,BufFilePre,BufRead * setlocal foldmethod=syntax
autocmd BufNewFile,BufFilePre,BufRead * normal zR

"Tab change with leader
noremap <leader>t gt
noremap <leader>T gT
"Consider _ a word delimiter
set iskeyword+=_
