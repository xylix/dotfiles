" Headless helper used by install.sh:
"     nvim --headless -c 'source <this file>'
" coc.nvim installs any missing g:coc_global_extensions by itself on startup,
" but asynchronously, so a plain "+qa" would kill nvim before it finishes.
" This keeps nvim alive until every extension is recorded in coc's
" extensions/package.json, then quits. Exits non-zero after a timeout.
" Not sourced by nvim normally: files in the config root are inert.
function! s:installed() abort
  let file = coc#util#extension_root() . '/package.json'
  if !filereadable(file) | return 0 | endif
  let deps = get(json_decode(join(readfile(file), "\n")), 'dependencies', {})
  for name in get(g:, 'coc_global_extensions', [])
    if !has_key(deps, name) | return 0 | endif
  endfor
  return 1
endfunction

let s:elapsed = 0
function! s:poll(timer) abort
  let s:elapsed += 2
  if s:installed()
    echom 'coc: all global extensions installed' | qa!
  elseif s:elapsed >= 600
    echoerr 'coc: timed out waiting for extension install' | cq
  endif
endfunction
call timer_start(2000, function('s:poll'), {'repeat': -1})
