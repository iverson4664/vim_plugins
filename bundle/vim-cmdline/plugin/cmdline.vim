" command line window configuration

if !has("cmdline_hist") || !has("vertsplit")
    finish
en

" set ch=1 " cmdheight
" let &cmdwinheight=20

fu! s:ExecuteCurrent()
    call feedkeys("\<CR>")
endf

fu! s:QuitCommandLine()
    exec ":q"
endf

let [s:lcmap, s:prtmaps] = ['nn <script> <buffer> <silent>', {
    \ 'ExecuteCurrent()':                ['o'],
    \ 'QuitCommandLine()':               ['<c-c>'],
    \ }]

fu! s:MapKeys()
    for [ke, va] in items(s:prtmaps) | for kp in va
        exe s:lcmap kp ':cal <SID>'.ke.'<cr>'
    endfo | endfo

endf

fu! s:Enter()
    call s:MapKeys()
endf

if has('autocmd')
    aug CmdWinAug
        au!
        au CmdWinEnter * cal s:Enter()
    aug END
en
