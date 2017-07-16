set nocompatible              " be iMproved, required
"filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-syntastic/syntastic'
"keyrepeat preventator
Plugin 'takac/vim-hardtime'
"autocompletion integration
Plugin 'Valloric/YouCompleteMe'
"swiss knife for searching
Plugin 'kien/ctrlp.vim'
"1.3mb worth of color schemes, found in .vim/bundle/vim-colorschemes/colors
Plugin 'flazz/vim-colorschemes'
"faster movement within lines
Plugin 'unblevable/quick-scope'
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
set background=dark
colorscheme gotham
set hidden
set omnifunc=syntaxcomplete#Complete
set expandtab
set relativenumber
set laststatus=2
"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use
set path=$PWD/**        "bubble gum for browsing project files
set tabstop=4 softtabstop=4 shiftwidth=4
au BufNewFile,BufRead *.js, *.html, *.css
    \ set softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.py
    \ set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix 
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:hardtime_default_on = 1
"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))

