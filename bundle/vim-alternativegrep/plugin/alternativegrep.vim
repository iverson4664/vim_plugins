" happy's alternative grep, sometimes search by grep,find.

if exists('loaded_atgrep')
    finish
endif

let loaded_atgrep=1

fun! s:AlternativeGrepValidatePath(path)
    if a:path == ""
        echomsg "no directory specified"
        return ""
    endif

    let l:fullpath = fnamemodify(a:path, ":p")

    if !isdirectory(l:fullpath)
        echomsg "directory " . l:fullpath . " doesn't exist"
        return ""
    endif

    let l:fullpath = substitute(l:fullpath, "\/$", "", "")
    return l:fullpath
endfun

fu! s:AlternativeGrep(type, opt, word)
    let l:op = "grep!"
    let l:prefix = "Search "

    let l:ex = ""
    if a:opt == 1
        let l:opt = "wnrs"
    elsei a:opt == 2
        let l:ex = "e"
        let l:opt = "nrs"
    el
        let l:opt = "wnrs"
    en


    " 1 from cword, 2 form user defined
    if a:type == 1
        let l:str = a:word
    elsei a:type == 2
        cno <space> <cr>
        call inputsave()
        let l:str = input(l:ex . l:prefix)
        call inputrestore()
        cu <space>
    el
        let l:str = a:word
    en

    call inputsave()
    let l:curdir = "./"
    " let l:curdir = getcwd() . "/"
    let l:rawpath = input(l:ex . l:prefix . l:str . " ", l:curdir, "file")
    call inputrestore()
    " echomsg " "

    let l:path = s:AlternativeGrepValidatePath(l:rawpath)
    if l:path == ""
        return
    endif

    let l:savedsp = &shellpipe
    " silentoutput: donot show shell results during searching
    " ->: the string > after '-' will be used by shellpipe
    let &shellpipe = "silentoutput->"
    execute "silent " . l:op . " " . l:str . " -" . l:opt . " " . l:path | copen
    let &shellpipe = l:savedsp
endf

" grep under-cursor string
nnoremap <Space>\\s :call <SID>AlternativeGrep(1, 1, expand("<cword>"))<CR>
nnoremap <Space>\\e :call <SID>AlternativeGrep(1, 2, expand("<cword>"))<CR>
" grep user defined string
nnoremap <Space>\\g :call <SID>AlternativeGrep(2, 1, expand("<cword>"))<CR>
nnoremap <Space>\\t :call <SID>AlternativeGrep(2, 2, expand("<cword>"))<CR>
" nnoremap <Space>\\f :call <SID>AlternativeGrep(3, expand("<cword>"))<CR>
nnoremap <Space>\\f : -name <C-R>=expand("<cword>")<CR>.* <C-b>!find ./

