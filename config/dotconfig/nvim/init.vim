set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
call plug#begin('~/.vim/plugged')

"Swiss knife for opening & finding files
Plug 'ctrlpvim/ctrlp.vim'
" Git diff column in the gutter
Plug 'airblade/vim-gitgutter'
" Conflict detection and custom highlighting
Plug 'rhysd/conflict-marker.vim'
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
"WhichKey keybind helper tool
Plug 'liuchengxu/vim-which-key'

call plug#end()
"# (neo)vim configuration
set tabline=%!Tabline()

if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal! g'\"" | endif
endif
set encoding=utf-8
set title " Show current file in title
set mouse=a
set linebreak
set backspace=2 " make backspace work like most other programs
set number
set laststatus=0
set shiftwidth=4
set clipboard=unnamedplus
"Consider _ a word delimiter
set iskeyword+=_
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
colorscheme deus
let g:deus_termcolors=256

"Configure folds by syntax by default and open files with all folds open
autocmd BufNewFile,BufFilePre,BufRead * setlocal foldmethod=syntax
autocmd BufNewFile,BufFilePre,BufRead * normal zR

"Allow esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>
"Disable line numbers in terminal mode
au TermOpen * setlocal listchars= nonumber norelativenumber

"Leader keybinds
let mapleader = " "
" tab terminal
noremap <leader>tt :tabnew<bar>terminal<CR>
noremap <leader>j :jumps<CR>
"Highlights off
noremap <silent> <leader>ho :noh<CR> 
" help tab
noremap <leader>ht :tab help 
"Tab change with leader
noremap <leader>t :tabnext<CR>
noremap <leader>T :tabprevious<CR>

nmap <leader>rn <Plug>(coc-rename)
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>g <Plug>(coc-declaration)
"Hotkeys to jump to next and prev error
nmap <leader>n <Plug>(coc-diagnostic-next-error)

" This still doesn't work
nmap <leader>p <Plug>(coc-diagnostic-previous-error)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <F1> :call <SID>show_documentation()<CR>

"Setup config dir variable and source tab bar number function 
let nvim_config_dir = stdpath('config')
exec 'source' nvim_config_dir . '/tab-bar.vim'
exec 'source' nvim_config_dir . '/conflict-marker-config.vim'

noremap <silent> <C-S> :update<CR>
noremap <Leader>s :update<CR>
"# Plugin and Filetype configurations

let ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"jsx js tsx ts config
autocmd FileType javascript,javascriptreact,typescript,typescriptreact set tabstop=4 shiftwidth=4 expandtab
".md config
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
autocmd FileType markdown :CocDisable
autocmd FileType markdown set nonumber
" Latex configuration
autocmd FileType tex set nonumber
let tex_flavor='latex'
let vimtex_view_method='zathura'
let vimtex_quickfix_mode=0
let tex_conceal='abdmg'
"Pandoc config
let pandoc#spell#enabled = 0
let pandoc#modules#disabled = ["folding"]

let goyo_width=140
let goyo_height=100

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

let which_key_map = {}
let which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : ['resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : ['resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }
nnoremap <c-w> :WhichKey '<c-w>'<cr>
