function LeaderKeybinds()
    let g:mapleader = " "
    " let g:maplocalleader = " " this would do things weirdly

    "C-S and leader-s to save
    noremap <silent><C-S> :update<CR>
    noremap <silent><leader> :WhichKey '<Space>'<CR>
    " noremap <silent> g :WhichKey 'g'<CR> "this doesn't work, apparently
    " whichkey doesn't work with build-in keybinds?

    " Save File if changes
    noremap <silent><leader>s :update<CR>
    " Save Session to cwd with default filename (Session.vim)
    " noremap <leader>ss :mks!<CR>

    noremap <silent><leader>qq :quit<CR>
    " Write and quit all windows
    noremap <leader>qw :xall<CR>
    noremap <leader>qa :quitall<CR>
    " Quit without write and update session file
    noremap <leader>qs :mks!<CR>:quitall<CR>

    noremap <leader>j :jumps<CR>
    noremap <leader>ei :edit $MYVIMRC<CR>
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

    "Tab change with tab and shift tab
    noremap <silent><tab> gt<CR>
    noremap <silent><S-tab> :tabprevious<CR>
    " noremap <silent><leader><tab> gt<CR>
    " noremap <silent><leader><S-tab> :tabprevious<CR>
    " CoC keybinds
    nmap <leader>rn <Plug>(coc-rename)
    vmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>gd <Plug>(coc-declaration)
    nmap <leader>gr <Plug>(coc-references)

    "Hotkeys to jump to next and prev error
    nmap <silent><leader>n <Plug>(coc-diagnostic-next-error)
    " This still doesn't work
    nmap <silent><leader>p <Plug>(coc-diagnostic-previous-error)
    nmap <silent><leader>ca :call CocActionAsync("codeAction"))<CR>
    nmap <silent><leader>cl :CocList<CR>
    nmap <silent><leader>cc :CocCommand<CR>

    "Aerial (outline tool)
    noremap <leader>a :AerialToggle<CR>
    " inserts ISO timestamp
    nmap <leader>di i<C-R>=strftime("%FT%T%z")<CR><Esc>
    " inserts human readable time
    nmap <leader>dh i<C-R>=strftime("%d.%m.%Y %I:%M")<CR><Esc>

    autocmd CursorHold * silent call CocActionAsync('highlight')
    "Show git blame
    nmap <leader>gb :CocCommand git.showBlameDoc<CR>
endfunction

