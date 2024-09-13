" useful for debugging things that don't visibly log or error
"set verbosefile=~/.local/log/vim/verbose.log
" set verbose=1

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" vimwiki configs need to be set before it is loaded
let g:vimwiki_key_mappings = { 'all_maps': 0, }
let g:vimwiki_global_ext = 0
" let g:vimwiki_ext2syntax = {}
let g:vimwiki_list = [{'path': '~/logseq-database/', 'path_html': '~/logseq-database/build', 'syntax': 'markdown', 'ext': 'md'}]

call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim' "Swiss knife for opening & finding files
Plug 'rhysd/conflict-marker.vim' " Conflict detection and custom highlighting, TODO: can this be replcaed with coc-git?
Plug 'unblevable/quick-scope'
Plug 'ajmwagar/vim-deus'
Plug 'junegunn/goyo.vim' "Adds Goyo mode, which hides unnecessary visual clutter temporarily
Plug 'markonm/traces.vim' "Live substitution highlights
Plug 'rhysd/git-messenger.vim' "Way to check previous git commits in-line

Plug 'vimwiki/vimwiki'
Plug 'itchyny/lightline.vim' " Tab and statusline plugin

"IDE-like features
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':CocUpdateSync' }
"Good syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'liuchengxu/vim-which-key' "WhichKey keybind helper tool

" Haskell specific plugins
Plug 'alx741/vim-hindent' "Haskell autoformatting
Plug 'Twinside/vim-haskellFold' " improved haskell foldinfo

"Pandoc syntax support (an usable pandoc-flavoured latex supporting markdown etc. compiler)
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'lervag/vimtex' "Latex support

" In testing currently
Plug 'AndrewRadev/tagalong.vim' "Change both ends of a pair of html tags when editing tags
" Plug 'zsugabubus/crazy8.nvim'
Plug 'chrisbra/Colorizer' "Hex and css color highlighting

Plug 'tpope/vim-fugitive' " Git plugin

Plug 'stevearc/aerial.nvim' "another outline view
" Plug 'derekelkins/agda-vim'

" Finnish spellchecking
" Plug 'git@github.com:xylix/Vimchant.git'
" set updatetime=1000
" let g:vimchant_spellcheck_lang = 'fi'

" Plug 'github/copilot.vim' "Github copilot
call plug#end()

"Setup config dir variable and source tab bar number function
let g:nvim_config_dir = stdpath('config')
exec 'source' nvim_config_dir . '/plugin-config.vim'
exec 'source' nvim_config_dir . '/vim-config.vim'
exec 'source' nvim_config_dir . '/leader-keybinds.vim'
exec 'source' nvim_config_dir . '/vimwiki.vim'
" exec 'source' nvim_config_dir . '/agda-config.vim'
" call AgdaOptions()

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
" Let neovim know we don't want to check or load ruby and perl integrations
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
lua <<EOF
  require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
  })
  -- treesitter setup
  require'nvim-treesitter.configs'.setup {

    ensure_installed = { "python", "bash", "dockerfile", "fish", "json", "json5", "yaml", "make", "toml", "haskell", "vim"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
      enable = true,              -- false will disable the whole extension
      disable = {"latex"},  -- list of language that will be disabled
    },
  }
EOF

call VimConfig()
call LeaderKeybinds()
call <SID>neo_vim_terminal_config()
call PluginOptions()
