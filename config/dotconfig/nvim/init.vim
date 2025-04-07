" useful for debugging things that don't visibly log or error
"set verbosefile=~/.local/log/vim/verbose.log
" set verbose=1
set t_Co=256
set termguicolors
" colorizer and deus need these

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" vimwiki configs need to be set before it is loaded
" let g:vimwiki_key_mappings = { 'all_maps': 0, }
" let g:vimwiki_global_ext = 0
" let g:vimwiki_ext2syntax = {}
" let g:vimwiki_list = [{'path': '~/logseq-database/', 'path_html': '~/logseq-database/build', 'syntax': 'markdown', 'ext': 'md'}]


"Setup config dir variable and source tab bar number function
let g:nvim_config_dir = stdpath('config')
exec 'source' nvim_config_dir . '/helpers.vim'
" configure vimwiki keybinds
let g:mapleader = " "

noremap <leader>vdn :VimwikiDiaryNextDay<CR>
noremap <leader>vdp :VimwikiDiaryPreviousDay<CR>
noremap <leader>vb :VimwikiBacklinks<CR>
noremap <CR> :VimwikiFollowLink<CR>
noremap <BS> :VimwikiGoBackLink<CR>

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
call <SID>neo_vim_terminal_config()

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
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazypath)

  -- Make sure to setup `mapleader` and `maplocalleader` before
  -- loading lazy.nvim so that mappings are correct.
  -- This is also a good place to setup other settings (vim.opt)
  vim.g.mapleader = " "
  vim.g.maplocalleader = "\\"

  -- Setup lazy.nvim
  require("lazy").setup({
    spec = {
      -- import plugins
      { import = "plugins" },
    },
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "deus" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
    -- Let lazy.nvim manage lua rocks (packages)
    rocks = {
      hererocks = true,
    }
  })

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

    ensure_installed = { "python", "bash", "dockerfile", "fish", "json", "json5", "yaml", "make", "toml", "haskell", "vim", "javascript", "typescript"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    auto_install = true,
    highlight = {
      enable = true,              -- false will disable the whole extension
      disable = {"latex"},  -- list of language that will be disabled
    },
  }
  require'colorizer'.setup()
  -- Define a formatting command to utilize conform
  vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = {"*.py", "*.lua" },
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
  })
  vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_format = "fallback", range = range })
    end, { range = true })
    -- Could also use CoC editor.action.formatDocument, but it allows less
    -- choice between formatters.
    vim.api.nvim_set_keymap('n', '<leader>cf', ':Format<CR>', {})
EOF

" VimConfig()
    set pyxversion=3
    set tabstop=4 shiftwidth=4 softtabstop=1 expandtab smarttab
    autocmd BufRead *.lua set tabstop=4 " Workaround because the above is not working for Lua files, `:verbose set tabstop?` didn't show any specific culprit.

    set foldtext=FoldText()

    " Start editing previously edited files where you left off
    if has("autocmd")
	    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
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


    " strip trailing whitespace on write
    " This leads to accidental changes when working with projects that have
    " trailing whitespace in existing files. Would be more useful as a
    " per-project setting. Disabled this for now.
    " autocmd BufWritePre * :%s/\s\+$//e

    autocmd FileType help wincmd T "open help pages in new tabs

" LeaderKeybinds()
    let g:mapleader = " "
    " let g:maplocalleader = " " this would do things weirdly
    noremap <silent><leader> :WhichKey '<Space>'<CR>
    " noremap <silent> g :WhichKey 'g'<CR> "TODO: this doesn't work, apparently whichkey doesn't work with build-in keybinds?
    "save file if changes
    noremap <leader>s :update<CR>
    "quit but not if there are unsaved changes
    noremap <silent><leader>qq :quit<CR>
    " Write and quit all windows
    noremap <leader>qw :xall<CR>
    " Quit all windows without saving
    noremap <leader>qa :quitall<CR>
    " Quit without write and update session file
    " Save Session to cwd with default filename (Session.vim)
    noremap <leader>qs :mksession!<CR>:quitall<CR>

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
    "Aerial (outline tool)
    noremap <leader>a :AerialToggle<CR>
    " inserts ISO timestamp
    nmap <leader>di i<C-R>=strftime("%FT%T%z")<CR><Esc>
    " inserts human readable time
    nmap <leader>dh i<C-R>=strftime("%d.%m.%Y %I:%M")<CR><Esc>


" PluginOptions()
    colorscheme deus

    " FIXME: This works, the version in spec1.lua doesn't
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


    " let g:colorizer_auto_color = 1
    " autocmd BufNewFile,BufRead * :ColorHighlight
    " Latex configuration
    let g:tex_flavor='latex' " Default tex file format
    let g:tex_conceal='abdmg'

    function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " CoC configs
    function s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
	    execute 'tab help '.expand('<cword>')
	else
	    call CocAction('doHover')
	endif
    endfunction

    nnoremap <F1> :call <SID>show_documentation()<CR>
    nnoremap <Leader>hh :call <SID>show_documentation()<CR>

    " inoremap <silent><expr> <TAB>
    "  \ coc#pum#visible() ? coc#pum#next(1) :
    "  \ CheckBackspace() ? "\<Tab>" :
    "  \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

    " Make <CR> to accept selected completion item or notify coc.nvim to format
    " <C-g>u breaks current undo, please make your own choice.
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    " Use <c-space> to trigger completion.
    if has('nvim')
      inoremap <silent><expr> <c-enter> coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif
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
    autocmd CursorHold * silent call CocActionAsync('highlight')
    "Show git blame
    nmap <leader>gb :CocCommand git.showBlameDoc<CR>
    " Coc configs over


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


" Ignore urls and uris in spellchecking
" doesn't yet quite work, doesn't capture the full URLs. But the first regex
" does match fine when pasted into vims /
" syn match urls "https\=:\/\/[-a-zA-Z0-9.\/@+%?#_]\+/" contains=@NoSpell
" source: https://www.reddit.com/r/vim/comments/18l5nvp/is_there_a_way_what_spelling_ignore_url_for/
syn match uris '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell
" source: https://vi.stackexchange.com/a/24534
