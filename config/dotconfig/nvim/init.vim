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

"Setup config dir variable and source tab bar number function 
let g:nvim_config_dir = stdpath('config')
exec 'source' nvim_config_dir . '/vim-config.vim'
exec 'source' nvim_config_dir . '/plugin-config.vim'
exec 'source' nvim_config_dir . '/leader-keybinds.vim'
    
function s:neo_vim_terminal_config()
    "terminal in new tab
    noremap <silent><leader>tt :tabnew<bar>terminal<CR>
    "Allow esc to exit terminal mode
    tnoremap <Esc> <C-\><C-n>
    "Disable line numbers in terminal mode
    au TermOpen * setlocal listchars= nonumber norelativenumber
endfunction

" @arg namespace: namespace where to set settings
" @arg ...: tuples containing a key and a value to be set within the namespace
function SetManyOptions(namespace, ...)
    for i in a:000
	let a:namespace . l:i:0 = l:i:1<space>
    endfor
endfunction

call VimConfig()
call LeaderKeybinds()
call <SID>neo_vim_terminal_config()
call ConflictMarkerOptions()
call PluginOptions()
