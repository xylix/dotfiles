set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim' "Swiss knife for opening & finding files
Plug 'airblade/vim-gitgutter' " Git diff column in the gutter
Plug 'rhysd/conflict-marker.vim' " Conflict detection and custom highlighting
Plug 'unblevable/quick-scope'
Plug 'ajmwagar/vim-deus'
Plug 'junegunn/goyo.vim' "Adds Goyo mode, which hides unnecessary visual clutter temporarily

"IDE-like features
Plug 'neoclide/coc.nvim', {'branch': 'release' }
Plug 'sheerun/vim-polyglot' "Syntax highlighting & formatting
"Pandoc syntax support (an usable pandoc-flavoured latex supporting markdown etc. compiler)
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex' "Latex support
Plug 'liuchengxu/vim-which-key' "WhichKey keybind helper tool

call plug#end()

function VimConfig() 
    set tabline=%!Tabline()

    if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		    \| exe "normal! g'\"" | endif
    endif

    set encoding=utf-8
    set mouse=a
    set linebreak number title
    set backspace=2 " make backspace work like most other programs
    set laststatus=0
    set shiftwidth=4
    set clipboard=unnamedplus
    "Consider _ a word delimiter
    set iskeyword+=_

    "Hide buffer something
    set hidden
    "Store an undo buffer in a file in $HOME/.vimundo
    set undofile
    set undolevels=1000
    set undoreload=10000
    "Set deus as colorscheme and some related variables to ensure proper background 
    set t_Co=256
    set termguicolors
    
    "Configure folds by syntax by default and open files with all folds open
    autocmd BufNewFile,BufFilePre,BufRead * setlocal foldmethod=syntax
    autocmd BufNewFile,BufFilePre,BufRead * normal zR

endfunction
    
function LeaderKeybinds() 
    let g:mapleader = " "
    "C-S and leader-s to save
    noremap <silent><C-S> :update<CR>
    noremap <Leader>s :update<CR>
    noremap <silent><leader> :WhichKey '<Space>'<CR>

    noremap <leader>j :jumps<CR>
    "Highlights off
    noremap <silent> <leader>ho :noh<CR> 

    noremap <leader>th :tab help
    noremap <silent><leader>tn :tabnew<CR>
    noremap <silent><leader>tx :tabclose<CR>
    
    "Window close, split horizontal and split vertical
    noremap <silent><leader>wx <C-W>c
    noremap <silent><leader>wh <C-W>s
    noremap <silent><leader>wv <C-W>v

    "Tab change with leader tab and shift tab
    noremap <leader><tab> gt<CR>
    noremap <leader><S-tab> :tabprevious<CR>
    " CoC keybinds
    nmap <leader>rn <Plug>(coc-rename)
    vmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>g <Plug>(coc-declaration)

    "Hotkeys to jump to next and prev error
    nmap <leader>n <Plug>(coc-diagnostic-next-error)
    " This still doesn't work
    nmap <leader>p <Plug>(coc-diagnostic-previous-error)
endfunction

function NeoVimOptions()
    "terminal in new tab
    noremap <silent><leader>tt :tabnew<bar>terminal<CR>
    "Allow esc to exit terminal mode
    tnoremap <Esc> <C-\><C-n>
    "Disable line numbers in terminal mode
    au TermOpen * setlocal listchars= nonumber norelativenumber
endfunction

function PluginOptions()
    "# Plugin and Filetype configurations
    colorscheme deus
    let g:deus_termcolors=256

    let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
    "jsx js tsx ts config
    autocmd FileType javascript,javascriptreact,typescript,typescriptreact set tabstop=4 shiftwidth=4 expandtab
    "markdown config
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

    let g:goyo_width=140
    let g:goyo_height=100
endfunction

call VimConfig()
call LeaderKeybinds()
call NeoVimOptions()
call PluginOptions()

function s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'tab help '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <F1> :call <SID>show_documentation()<CR>
nnoremap <Leader>hh :call <SID>show_documentation()<CR>

"Setup config dir variable and source tab bar number function 
let g:nvim_config_dir = stdpath('config')
exec 'source' nvim_config_dir . '/tab-bar.vim'
exec 'source' nvim_config_dir . '/conflict-marker-config.vim'
