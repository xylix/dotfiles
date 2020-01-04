" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')

"Swiss knife for searching
Plug 'kien/ctrlp.vim'

Plug 'unblevable/quick-scope'
Plug 'ajmwagar/vim-deus'

"Plug for Goyo mode, which hides unnecessary visual clutter temporarily
Plug 'junegunn/goyo.vim'

"Programming language (IDE) stuff
Plug 'neoclide/coc.nvim', {'branch': 'release' }

call plug#end()
filetype plugin indent on
syntax on

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

set encoding=utf-8
let mapleader = ","
set linebreak

"Store an undo buffer in a file in $HOME/.vimundo
set undofile
set undodir=$HOME/.vim/vimundo
set undolevels=1000
set undoreload=10000

"Hide buffer something
set hidden

set omnifunc=syntaxcomplete#Complete

set foldmethod=indent foldnestmax=1 nofoldenable   

set path=$PWD/**        "bubble gum for browsing project files
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

"Set deus as colorscheme and some related variables to ensure proper
"background 
set t_Co=256
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark " Setting dark mode
colorscheme deus
let g:deus_termcolors=256

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

set laststatus=0
set wildignore+=*/target/*

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
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

set backspace=2 " make backspace work like most other programs
set number
set autoread

noremap <Leader>s :update<CR>

inoremap <silent><expr> <c-space> coc#refresh()
