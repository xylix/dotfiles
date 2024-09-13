function PluginOptions()
    colorscheme deus
    let g:deus_termcolors=256

    " Disable conflict market feature that requires matchit.vim
    let g:conflict_marker_enable_matchit = 0
    " Replace conflict marker plugin default coloring settings with own
    let g:conflict_marker_highlight_group = ''
    " Include text after begin and end markers
    let g:conflict_marker_begin = '^<<<<<<< .*$'
    let g:conflict_marker_end   = '^>>>>>>> .*$'
    " Set highlight colors
    highlight ConflictMarkerBegin guibg=#2f7366
    highlight ConflictMarkerOurs guibg=#2e5049
    highlight ConflictMarkerTheirs guibg=#344f69
    highlight ConflictMarkerEnd guibg=#2f628e
    "Keep none: cn or :ConflictMarkerNone
    "Keep ours: co or :ConflictMarkerOurselves
    "Keep theirs: ct or :ConflictMarkerThemselves
    "Keep both cb or :ConflictMarkerBoth

    " let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
    let g:ctrlp_user_command = 'fd --hidden --type f --color=never "" %s'
    let g:ctrlp_use_caching = 0

    " let g:colorizer_auto_color = 1
    " autocmd BufNewFile,BufRead * :ColorHighlight
    " Latex configuration
    let g:tex_flavor='latex' " Default tex file format
    let g:vimtex_view_method = 'skim' " Choose which program to use to view PDF file
    let g:vimtex_view_skim_sync = 1 " Value 1 allows forward search after every successful compilation
    let g:vimtex_view_skim_activate = 1 " Value 1 allows change focus to skim after command `:VimtexView` is given
    let g:vimtex_quickfix_mode=0
    let g:tex_conceal='abdmg'
    "Pandoc config
    let g:pandoc#spell#enabled = 0
    let g:pandoc#modules#disabled = ["folding"]

    let g:goyo_width=140
    let g:goyo_height=100

    function s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
	    execute 'tab help '.expand('<cword>')
	else
	    call CocAction('doHover')
	endif
    endfunction

    nnoremap <F1> :call <SID>show_documentation()<CR>
    nnoremap <Leader>hh :call <SID>show_documentation()<CR>

    let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-yaml', 'coc-pyright', 'coc-tsserver', 'coc-vimlsp', 'coc-sh', 'coc-snippets'] "todo: add coc r lsp and coc-texlab if they good

    " inoremap <silent><expr> <TAB>
    "  \ coc#pum#visible() ? coc#pum#next(1) :
    "  \ CheckBackspace() ? "\<Tab>" :
    "  \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

    " Make <CR> to accept selected completion item or notify coc.nvim to format
    " <C-g>u breaks current undo, please make your own choice.
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    if has('nvim')
      inoremap <silent><expr> <c-enter> coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " Lightline related
    set laststatus=2
    set noshowmode
    let g:lightline = {
      \ 'colorscheme': 'deus',
      \ }

    "vimwiki
    " let g:vimwiki_folding='custom'

    function! s:goto_tag(tagkind) abort
        let tagname = expand('<cWORD>')
        let winnr = winnr()
        let pos = getcurpos()
        let pos[0] = bufnr()

        if CocAction('jump' . a:tagkind)
            call settagstack(winnr, {
                        \ 'curidx': gettagstack()['curidx'],
                        \ 'items': [{'tagname': tagname, 'from': pos}]
                        \ }, 't')
        endif
    endfunction
    nmap gd :call <SID>goto_tag("Definition")<CR>
    nmap gi :call <SID>goto_tag("Implementation")<CR>
    nmap gr :call <SID>goto_tag("References")<CR>

endfunction
