function! MarkdownLevel()
    let h = matchstr(getline(v:lnum), '^#\+')
    if empty(h)
        return "="
    else
        return ">" . len(h)
    endif
endfunction

function! FoldText()
    let l:lpadding = &fdc
    redir => l:signs
	execute 'silent sign place buffer='.bufnr('%')
    redir End
    let l:lpadding += l:signs =~ 'id=' ? 2 : 0

    " Won't work with relativenumbers, they require some bubblegum
    if (&number)
	let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 1
    endif

    " expand tabs
    let l:start = substitute(getline(v:foldstart), '\t', repeat(' ', &tabstop), 'g')
    let l:end = substitute(substitute(getline(v:foldend), '\t', repeat(' ', &tabstop), 'g'), '^\s*', '', 'g')

    let l:width = winwidth(0) - l:lpadding

    let l:separator = ' … '
    let l:separatorlen = strlen(substitute(l:separator, '.', 'x', 'g'))
    let l:start = strpart(l:start , 0, l:width - strlen(substitute(l:end, '.', 'x', 'g')) - l:separatorlen)
    let l:text = l:start . ' … ' . l:end

    return l:text  . repeat(' ', l:width - strlen(substitute(l:text, ".", "x", "g")))
endfunction
