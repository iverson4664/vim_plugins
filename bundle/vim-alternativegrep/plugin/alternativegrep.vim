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

fu! s:AlternativeGrep(type, word)
    let l:op="grep!"

    if a:type == 1
        let l:opt="wnrs"
    elsei a:type == 2
        let l:opt="nrs"
    elsei a:type == 3
    el
    en

    call inputsave()
    let l:curdir = "./"
    " let l:curdir = getcwd() . "/"
    let l:rawpath = input("Search from ", l:curdir, "file")
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
    execute "silent " . l:op . " " . a:word . " -" . l:opt . " " . l:path | copen
    let &shellpipe = l:savedsp
endf

nnoremap <Space>\\s :call <SID>AlternativeGrep(1, expand("<cword>"))<CR>
nnoremap <Space>\\e :call <SID>AlternativeGrep(2, expand("<cword>"))<CR>
" nnoremap <Space>\\f :call <SID>AlternativeGrep(3, expand("<cword>"))<CR>
nnoremap <Space>\\f : -name <C-R>=expand("<cword>")<CR>.* <C-b>!find ./

