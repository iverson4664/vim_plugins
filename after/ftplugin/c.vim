"
" C Filetype Plugin

setlocal formatoptions=crq
setlocal textwidth=80

" Indents are 4 spaces
setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

setlocal noexpandtab

" Setup for indending
setlocal nosmartindent
setlocal autoindent
setlocal cinkeys-=0#
setlocal cinoptions+=^
setlocal cinoptions+=g0
setlocal cinoptions+=:0
setlocal cinoptions+=(0
" happy added for lambda
setlocal cinoptions+=t0,N-s,l1
setlocal cindent cino+=j1,(0,ws,Ws

" Highlight strings inside C comments
let c_comment_strings=1

" Load up the doxygen syntax
let g:load_doxygen_syntax=1

