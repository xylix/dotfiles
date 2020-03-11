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
