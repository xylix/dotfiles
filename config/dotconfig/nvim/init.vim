set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
call plug#begin('~/.vim/plugged')

"Swiss knife for opening / changing files
Plug 'kien/ctrlp.vim'

Plug 'unblevable/quick-scope'
Plug 'ajmwagar/vim-deus'
"Adds Goyo mode, which hides unnecessary visual clutter temporarily
Plug 'junegunn/goyo.vim'
"IDE-like features
Plug 'neoclide/coc.nvim', {'branch': 'release' }
Plug 'preservim/nerdtree'
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
let mapleader = ","
set mouse=a
set linebreak
set backspace=2 " make backspace work like most other programs
set number
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

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Latex configuration
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

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

"Set autocommand to open nerdtree when opening vim without a file argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <silent> <C-S> :<C-u>Update<CR>
noremap <Leader>s :update<CR>
inoremap <silent><expr> <c-space> coc#refresh()
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
autocmd FileType markdown :CocDisable
autocmd FileType markdown set nonumber
autocmd FileType tex set nonumber

let g:pandoc#spell#enabled = 0
let g:pandoc#modules#disabled = ["folding"]

let g:goyo_width=140
let g:goyo_height=100

