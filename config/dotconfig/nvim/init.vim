" useful for debugging things that don't visibly log or error
"set verbosefile=~/.local/log/vim/verbose.log
" set verbose=1

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" vimwiki configs need to be set before it is loaded
" let g:vimwiki_key_mappings = { 'all_maps': 0, }
" let g:vimwiki_global_ext = 0
" let g:vimwiki_ext2syntax = {}
" let g:vimwiki_list = [{'path': '~/logseq-database/', 'path_html': '~/logseq-database/build', 'syntax': 'markdown', 'ext': 'md'}]

call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim' "Swiss knife for opening & finding files
Plug 'rhysd/conflict-marker.vim' " Conflict detection and custom highlighting, TODO: can this be replcaed with coc-git?
Plug 'unblevable/quick-scope'
Plug 'ajmwagar/vim-deus'
Plug 'junegunn/goyo.vim' "Adds Goyo mode, which hides unnecessary visual clutter temporarily
Plug 'rhysd/git-messenger.vim' "Way to check previous git commits in-line

" Plug 'vimwiki/vimwiki'
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
Plug 'norcalli/nvim-colorizer.lua'  "Hex and css color highlighting
set termguicolors "colorizer needs this


Plug 'tpope/vim-fugitive' " Git plugin

Plug 'stevearc/aerial.nvim' "another outline view
" Plug 'derekelkins/agda-vim'

if $KITTY_WINDOW_ID != ""
    Plug '3rd/image.nvim' "inline images
endif

" Finnish spellchecking
" Plug 'git@github.com:xylix/Vimchant.git'
" set updatetime=1000
" let g:vimchant_spellcheck_lang = 'fi'

" Plug 'github/copilot.vim' "Github copilot
call plug#end()

"Setup config dir variable and source tab bar number function
let g:nvim_config_dir = stdpath('config')
exec 'source' nvim_config_dir . '/helpers.vim'
exec 'source' nvim_config_dir . '/plugin-config.vim'
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
  require'colorizer'.setup()
  if os.getenv("KITTY_WINDOW_ID") then
  -- configure system luarocks that image.nvim uses
  package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
  package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"
  require("image").setup({
    backend = "kitty",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
      },
      neorg = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "norg" },
      },
      html = {
        enabled = false,
      },
      css = {
        enabled = false,
      },
    },
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    max_height_window_percentage = 50,
    window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
    tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
  })
  end
EOF

function! VimConfig()
    set pyxversion=3
    set tabstop=4 shiftwidth=4 softtabstop=1 expandtab smarttab

    set foldtext=FoldText()

    if has("autocmd")
	autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		    \| exe "normal! g'\"" | endif
    endif
    lang en_US.UTF-8

    set autoread
    set encoding=utf-8
    set mouse=a
    set linebreak number title
    set backspace=2 " make backspace work like most other programs
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
    set fillchars=fold:\
    autocmd BufNewFile,BufFilePre,BufRead * normal zR

    autocmd BufNewFile,BufFilePre,BufRead *.ts setlocal filetype=typescript
    autocmd BufNewFile,BufFilePre,BufRead *.tsx setlocal filetype=typescript
    autocmd BufNewFile,BufFilePre,BufRead *.js  setlocal filetype=javascript
    autocmd BufNewFile,BufFilePre,BufRead *.jsx  setlocal filetype=javascript
    autocmd FileType typescript,javascript set tabstop=2 shiftwidth=2 softtabstop=0 expandtab smarttab

    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType python set tabstop=4 shiftwidth=4 softtabstop=0 expandtab smarttab colorcolumn=88

    autocmd FileType rst set colorcolumn=88

    autocmd FileType robot set tabstop=4 shiftwidth=4 softtabstop=0 expandtab smarttab colorcolumn=120

    "markdown config
    autocmd BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown
    autocmd FileType markdown setlocal nonumber
    " autocmd FileType tex setlocal nonumber

    " Vimwiki folds need to be configured after the plugin is initialized and
    " the folding overwritten
    "autocmd FileType markdown,vimwiki setlocal
    "    \ foldmethod=expr
    "    \ foldtext=FoldText()
    "    \ foldexpr=MarkdownLevel()

    autocmd BufNewFile,BufRead *.robot setlocal filetype=robot
    autocmd FileType robot exec 'source' g:nvim_config_dir . '/syntax/robot.vim'

    autocmd FileType haskell syn match haskellLambda '\\' conceal cchar=λ
    autocmd FileType haskell set conceallevel=2 concealcursor=nv
    autocmd FileType haskell syn match haskellCompose '\.' conceal cchar=∘

    autocmd FileType latex,tex set conceallevel=2 concealcursor=nv

    autocmd BufNewFile,BufFilePre,BufRead *.hbs setlocal filetype=handlebars
    autocmd FileType handlebars set syntax=html

    set listchars=eol:$,nbsp:_,tab:>-,trail:~,extends:>,precedes:<

    " Disable ex mode hotkey and command history search hotkey
    map q: <Nop>
    nnoremap Q <nop>

    " Do not paste from system clipboard on windows (can result in encoding
    " problems)
    if system('uname -r') =~ "microsoft"
	augroup Yank
	    autocmd!
	    autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
        augroup END
    else
        set clipboard=unnamedplus
    endif


    " strip trailing whitespace
    autocmd BufWritePre * :%s/\s\+$//e

    autocmd FileType help wincmd T "open help pages in new tabs
endfunction
call VimConfig()
call LeaderKeybinds()
call <SID>neo_vim_terminal_config()
call PluginOptions()
