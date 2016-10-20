" happy's quickfix

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

fu! s:BufferExist(bufname)
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

fu! s:BufferIsOpen()
    " &filetye == 'qf'
    if &buftype == 'quickfix'
        return 1
    en
    return 0
endf

fu! s:CloseQuickfixWin()
    noa winc p
    exec ":ccl"
endf

fu! s:CloseAllQuickfixWin()
    noa winc p
    exec ":ccl"
    exec ":lcl"
endf

fu! s:ToggleQuickfixWin()
    if s:BufferExist("Quickfix List")
        if s:BufferIsOpen()
            call s:CloseQuickfixWin()
        el
            exec ":ccl"
        en
    else
        exec ":botright cw" . g:QuickfixWinHeight
    endif
endf

fu! s:OpenCurrentFile()
    call feedkeys("\<CR>")
endf

" Global options
" let s:glbs = { 'magic': 1, 'to': 1, 'tm': 0, 'sb': 1, 'hls': 0, 'im': 0,
" 	\ 'report': 9999, 'sc': 0, 'ss': 0, 'siso': 0, 'mfd': 200, 'ttimeout': 0,
" 	\ 'gcr': 'a:blinkon0', 'ic': 1, 'lmap': '', 'mousef': 0, 'imd': 1 }

let [s:lcmap, s:prtmaps] = ['nn <script> <buffer> <silent>', {
    \ 'CloseAllQuickfixWin()':            ['<c-c>', 'q'],
    \ 'OpenCurrentFile()':                ['o'],
    \ }]

fu! s:MapKeys()
    if !( exists('s:smapped') && s:smapped == s:qfix_win)
        " Correct arrow keys in terminal
        if ( has('termresponse') && v:termresponse =~ "\<ESC>" )
                    \ || &term =~? '\vxterm|<k?vt|gnome|screen|linux|ansi'
            for each in ['\A <up>','\B <down>','\C <right>','\D <left>']
                exe s:lcmap.' <esc>['.each
            endfo
        en
    en

    nnoremap <script> <silent> <c-n> :cn<CR>
    nnoremap <script> <silent> <c-p> :cp<CR>

    " nnoremap <script> <buffer> <silent> <c-c> :call <SID>CloseQuickfixWin()<CR>
    " nnoremap <script> <buffer> <silent> <esc> :call <SID>CloseQuickfixWin()<CR>

    for [ke, va] in items(s:prtmaps) | for kp in va
        exe s:lcmap kp ':cal <SID>'.ke.'<cr>'
    endfo | endfo

    let s:smapped = s:qfix_win
endf

fu! s:Enter()
    let s:qfix_win = bufnr("$")

    " speed up esc key response
    " for [ke, va] in items(s:glbs) | if exists('+'.ke)
    "     sil! exe 'let s:glb_'.ke.' = &'.ke.' | let &'.ke.' = '.string(va)
    " en | endfo

    call s:MapKeys()

endf

fu! s:Exit()
    if exists('s:qfix_win')

        " for key in keys(s:glbs) | if exists('+'.key)
        "     sil! exe 'let &'.key.' = s:glb_'.key
        " en | endfo

        unlet! s:qfix_win
    en
endf

com! ToggleQuickfixWin call s:ToggleQuickfixWin()

if has('autocmd')
    aug QfAug
        au!
        " au FileType qf call s:enter()
        autocmd BufWinEnter quickfix cal s:Enter()
        autocmd BufWinLeave * if exists("s:qfix_win") && expand("<abuf>") == s:qfix_win |
                            \   noa cal s:Exit() |
                            \ endif

        " autocmd WinEnter * if &buftype == 'quickfix' |
        "                  \ endif

        autocmd WinLeave * if &buftype == 'quickfix' |
                         \     call s:Exit() |
                         \ endif
    aug END
en
