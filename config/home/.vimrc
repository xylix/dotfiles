set nocompatible              " be iMproved, required
"filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-syntastic/syntastic'
"autocompletion integration
Plugin 'Valloric/YouCompleteMe'
"swiss knife for searching
Plugin 'kien/ctrlp.vim'
"1.3mb worth of color schemes, found in .vim/bundle/vim-colorschemes/colors
Plugin 'flazz/vim-colorschemes'
"faster movement within lines
Plugin 'unblevable/quick-scope'

Plugin 'ajmwagar/vim-deus'
"MArgin nicefyer
Plugin 'junegunn/goyo.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
" Store an undo buffer in a file in $HOME/.vimundo
set undofile
set undodir=$HOME/.vimundo
set undolevels=1000

set number
syntax on
colorscheme deus
set hidden
set omnifunc=syntaxcomplete#Complete
set expandtab
set laststatus=2
"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use
set path=$PWD/**        "bubble gum for browsing project files
set tabstop=4 softtabstop=4 shiftwidth=4
set directory=$HOME/.vim/swapfiles//


au BufNewFile,BufRead *.js, *.html, *.css
    \ set softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.py
    \ set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix 
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
"hi normal ctermbg=none
" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
" Remember to set `stty stop undef` in shell
command -nargs=0 -bar Update if &modified 
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
nnoremap <silent> <C-S> :<C-u>Update<CR>

set encoding=utf-8
