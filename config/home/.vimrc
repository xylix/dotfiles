set nocompatible              " be iMproved, required
"filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Swiss knife for searching
Plugin 'kien/ctrlp.vim'

Plugin 'unblevable/quick-scope'
Plugin 'ajmwagar/vim-deus'

    "Plugin for Goyo mode, which hides unnecessary visual clutter temporarily
Plugin 'junegunn/goyo.vim'

Plugin 'vimwiki/vimwiki'
Plugin 'michal-h21/vim-zettel'

"Programming language (IDE) stuff
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'


"All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

"See :h vundle for more details or wiki for FAQ
"Put your non-Plugin stuff after this line
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

set encoding=utf-8
let mapleader = ","
set linebreak

"Store an undo buffer in a file in $HOME/.vimundo
set undofile undodir=$HOME/.vimundo undolevels=1000
set directory=$HOME/.vim/swapfiles/ 

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

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"Configure syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 4
set laststatus=0
set wildignore+=*/target/*

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

"Python specific things & stuff
let python_highlight_all=1
au BufNewFile,BufRead *.py
    \ set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix 
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
set backspace=2 " make backspace work like most other programs
set number

noremap <Leader>s :update<CR>
