set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim' "Swiss knife for opening & finding files
Plug 'rhysd/conflict-marker.vim' " Conflict detection and custom highlighting, TODO: can this be replcaed with coc-git?
Plug 'unblevable/quick-scope'
Plug 'ajmwagar/vim-deus'
Plug 'junegunn/goyo.vim' "Adds Goyo mode, which hides unnecessary visual clutter temporarily
Plug 'markonm/traces.vim' "Live substitution highlights

"IDE-like features
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':CocUpdateSync' }
" Haskell specific plugins
Plug 'alx741/vim-hindent' "Haskell autoformatting
Plug 'Twinside/vim-haskellFold' " improved haskell foldinfo

"Pandoc syntax support (an usable pandoc-flavoured latex supporting markdown etc. compiler)
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex' "Latex support
Plug 'liuchengxu/vim-which-key' "WhichKey keybind helper tool
Plug 'rhysd/git-messenger.vim' "Way to check previous git commits in-line
Plug 'vimwiki/vimwiki'

" In testing currently
Plug 'itchyny/lightline.vim' " Tab and statusline plugin
Plug 'AndrewRadev/tagalong.vim' "Change both ends of a pair of html tags when editing tags
Plug 'zsugabubus/crazy8.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'chrisbra/Colorizer' "Hex and css color highlighting

Plug 'tpope/vim-fugitive' " Git plugin
let g:vimwiki_key_mappings = { 'all_maps': 0, }
call plug#end()

"Setup config dir variable and source tab bar number function 
let g:nvim_config_dir = stdpath('config')
exec 'source' nvim_config_dir . '/vim-config.vim'
exec 'source' nvim_config_dir . '/plugin-config.vim'
exec 'source' nvim_config_dir . '/leader-keybinds.vim'
exec 'source' nvim_config_dir . '/vimwiki.vim'

function s:neo_vim_terminal_config()
    "terminal in new tab
    noremap <silent><leader>tt :tabnew<bar>terminal<CR>
    "Allow esc to exit terminal mode
    tnoremap <Esc> <C-\><C-n>
    "Disable line numbers in terminal mode
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber
endfunction

" @arg namespace: namespace where to set settings
" @arg ...: tuples containing a key and a value to be set within the namespace
" function SetManyOptions(namespace, ...)
"    for i in a:000
"	let a:namespace . l:i:0 = l:i:1<space>
"    endfor
"endfunction

lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
      enable = true,              -- false will disable the whole extension
      disable = { "c", "ocaml", "ocamllex", "ql", "cpp", "verilog", "fennel", "nix", "clojure", "php"},  -- list of language that will be disabled
    },
  }
EOF

call VimConfig()
call LeaderKeybinds()
call <SID>neo_vim_terminal_config()
call PluginOptions()
