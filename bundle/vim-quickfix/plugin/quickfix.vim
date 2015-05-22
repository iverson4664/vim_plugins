"quickfix

if !exists('g:QuickfixWinHeight')
    let g:QuickfixWinHeight = 10
end

nnoremap <silent> <C-n> :cn<CR>
nnoremap <silent> <C-p> :cp<CR>
nnoremap <silent> <Esc> :CloseQuickfixWin<CR>
"nmap <C-t> :colder<CR>:cc<CR>

function! GetBufferList()
    redir =>buflist
    silent! ls
    redir END
    return buflist
endfunction

function! BufferIsOpen(bufname)
    let buflist = GetBufferList()
    for bufnum in map(
                \filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 
                \'str2nr(matchstr(v:val, "\\d\\+"))'
                \)
        if bufwinnr(bufnum) != -1
            return 1
        endif
    endfor
    return 0
endfunction

function! ToggleQuickfixWin()
    if BufferIsOpen("Quickfix List")
        exec ":ccl"
    else
        exec ":botright cw" . g:QuickfixWinHeight
    endif
endfunction

function! CloseQuickfixWin()
    if BufferIsOpen("Quickfix List")
        exec ":ccl"
    endif
endfunction

command! ToggleQuickfixWin call ToggleQuickfixWin()
command! CloseQuickfixWin call CloseQuickfixWin()
