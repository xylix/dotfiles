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
    let g:ctrlp_user_command = 'fd --type f --color=never "" %s'
    let g:ctrlp_use_caching = 0

    autocmd FileType markdown :CocDisable
    " Latex configuration
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
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

    let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-yaml', 'coc-pyright', 'coc-tsserver', 'coc-vimlsp', 'coc-rust-analyzer', 'coc-sh']

    " Lightline related
    set laststatus=2
    set noshowmode
    let g:lightline = {
      \ 'colorscheme': 'deus',
      \ }


endfunction
