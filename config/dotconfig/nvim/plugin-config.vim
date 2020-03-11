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
    
    function s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
	    execute 'tab help '.expand('<cword>')
	else
	    call CocAction('doHover')
	endif
    endfunction

    nnoremap <F1> :call <SID>show_documentation()<CR>
    nnoremap <Leader>hh :call <SID>show_documentation()<CR>
endfunction
