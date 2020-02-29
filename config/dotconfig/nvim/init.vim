set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
call plug#begin('~/.vim/plugged')

"Swiss knife for opening & finding files
Plug 'ctrlpvim/ctrlp.vim'
" Git diff column in the gutter
Plug 'airblade/vim-gitgutter'
Plug 'unblevable/quick-scope'
Plug 'ajmwagar/vim-deus'
"Adds Goyo mode, which hides unnecessary visual clutter temporarily
Plug 'junegunn/goyo.vim'
"IDE-like features
Plug 'neoclide/coc.nvim', {'branch': 'release' }
"Syntax highlighting & formatting
Plug 'sheerun/vim-polyglot'
"Pandoc syntax support (an usable pandoc-flavoured latex supporting markdown etc. compiler)
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
"Latex support
Plug 'lervag/vimtex'
call plug#end()

"# (neo)vim configuration
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal! g'\"" | endif
endif
set encoding=utf-8
set title " Show current file in title
let mapleader=","
set mouse=a
set linebreak
set backspace=2 " make backspace work like most other programs
set number
set laststatus=0
set shiftwidth=4
set clipboard=unnamedplus
" ??
setl conceallevel=0
" ??
set conceallevel=1

"Hide buffer something
set hidden

"Store an undo buffer in a file in $HOME/.vimundo
set undofile
set undolevels=1000
set undoreload=10000

"Set deus as colorscheme and some related variables to ensure proper background 
set t_Co=256
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark " Setting dark mode, default in nvim
colorscheme deus
let g:deus_termcolors=256


"Configure folds by syntax by default, and open files with all folds open
autocmd BufNewFile,BufFilePre,BufRead * setlocal foldmethod=syntax
autocmd BufNewFile,BufFilePre,BufRead * normal zR
"Tab change with leader
noremap <leader>t gt
noremap <leader>T gT
"Consider _ a word delimiter
set iskeyword+=_

"Setup config dir variable and source tab bar number function 
let nvim_config_dir = stdpath('config')
exec 'source' nvim_config_dir . '/tab-bar.vim'
set tabline=%!Tabline()

" Set C-s and leader-s as create file if not exist and save
" Remember to set `stty stop undef` in shell
command -nargs=0 -bar Update if &modified 
	    \    if empty(bufname('%'))
	    \        browse confirm write
	    \    else
	    \        confirm write
	    \    endif
	    \endif
noremap <silent> <C-S> :update<CR>
noremap <Leader>s :update<CR>


"# Plugin and Filetype configurations

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
autocmd FileType markdown :CocDisable
autocmd FileType markdown set nonumber
" Latex configuration
autocmd FileType tex set nonumber
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'
"Pandoc config
let g:pandoc#spell#enabled = 0
let g:pandoc#modules#disabled = ["folding"]
autocmd FileType javascript,javascriptreact,typescript,typescriptreact set tabstop=4 shiftwidth=4 expandtab

let g:goyo_width=140
let g:goyo_height=100
"C-space to refresh coc in insert mode
inoremap <silent><expr> <c-space> coc#refresh()
noremap <leader>g <Plug>coc-declaration
