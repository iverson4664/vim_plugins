"quickfix

if !exists('g:QuickfixWinHeight')
    let g:QuickfixWinHeight = 10
end

" nnoremap <silent> <C-n> :cn<CR>
" nnoremap <silent> <C-p> :cp<CR>
" nmap <C-t> :colder<CR>:cc<CR>

fu! s:GetBufferList()
    redir =>buflist
    silent! ls
    redir END
    return buflist
endf

fu! s:BufferIsOpen(bufname)
    let buflist = s:GetBufferList()
    for bufnum in map(
                \filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 
                \'str2nr(matchstr(v:val, "\\d\\+"))'
                \)
        if bufwinnr(bufnum) != -1
            return 1
        endif
    endfor
    return 0
endf

fu! s:CloseQuickfixWin()
    if s:BufferIsOpen("Quickfix List")
        exec ":ccl"
    endif
endf

fu! s:ToggleQuickfixWin()
    if s:BufferIsOpen("Quickfix List")
        exec ":ccl"
    else
        exec ":botright cw" . g:QuickfixWinHeight
    endif
endf

fu! s:MapKeys()
    nnoremap <script> <silent> <c-n> :cn<CR>
    nnoremap <script> <silent> <c-p> :cp<CR>
    nnoremap <script> <buffer> <silent> <c-c> :call <SID>CloseQuickfixWin()<CR>
    nnoremap <script> <buffer> <silent> <esc> :call <SID>CloseQuickfixWin()<CR>

endf

fu! s:Enter()
    let s:qfix_win = bufnr("$")

    call s:MapKeys()

endf

fu! s:Exit()
    if exists("s:qfix_win") && expand("<abuf>") == s:qfix_win
        unlet! s:qfix_win
    endif
endf

com! ToggleQuickfixWin call s:ToggleQuickfixWin()
com! CloseQuickfixWin call s:CloseQuickfixWin()

if has('autocmd')
    aug QfAug
        au!
        " au FileType qf call s:enter()
        autocmd BufWinEnter quickfix cal s:Enter()
        autocmd BufWinLeave * noa cal s:Exit()
    aug END
en
