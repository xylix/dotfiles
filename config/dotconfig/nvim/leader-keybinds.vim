function LeaderKeybinds() 
    let g:mapleader = " "
    "C-S and leader-s to save
    noremap <silent><C-S> :update<CR>
    noremap <Leader>s :update<CR>
    noremap <silent><leader> :WhichKey '<Space>'<CR>

    noremap <leader>q :quit<CR>
    noremap <leader>j :jumps<CR>
    "Highlights off
    noremap <silent> <leader>ho :noh<CR> 
    noremap <leader>rg :%s///g<left><left>

    noremap <leader>th :tab help<space>
    noremap <silent><leader>tn :tabnew<CR>
    noremap <silent><leader>tx :tabclose<CR>
    noremap <silent><leader>tm :tabmove<space>
    
    "Window close, split horizontal and split vertical
    noremap <silent><leader>wx <C-W>c
    noremap <silent><leader>wh <C-W>s
    noremap <silent><leader>wv <C-W>v

    "Tab change with leader tab and shift tab
    noremap <silent><leader><tab> gt<CR>
    noremap <silent><leader><S-tab> :tabprevious<CR>
    " CoC keybinds
    nmap <leader>rn <Plug>(coc-rename)
    vmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>gd <Plug>(coc-declaration)
    nmap <leader>gr <Plug>(coc-references)

    "Hotkeys to jump to next and prev error
    nmap <silent><leader>n <Plug>(coc-diagnostic-next-error)
    " This still doesn't work
    nmap <silent><leader>p <Plug>(coc-diagnostic-previous-error)
endfunction

