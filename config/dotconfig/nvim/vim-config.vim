function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .':'
    let s .= (bufname != '' ? '['. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')

    if bufmodified
      let s .= '[+] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  if (exists("g:tablineclosebutton"))
    let s .= '%=%999XX'
  endif
  return s
endfunction

function VimConfig() 
    set tabline=%!Tabline()

    if has("autocmd")
	autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		    \| exe "normal! g'\"" | endif
    endif

    set autoread
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
    set foldmethod=syntax
    autocmd BufNewFile,BufFilePre,BufRead * normal zR
    
    autocmd FileType python setlocal foldmethod=indent
    "jsx js tsx ts config
    autocmd FileType javascript,javascriptreact,typescript,typescriptreact setlocal tabstop=4 shiftwidth=4 expandtab
    "markdown config
    autocmd BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown
    autocmd FileType markdown setlocal nonumber
    autocmd FileType tex setlocal nonumber

endfunction
