au FileType c,cpp,h,hpp call <SID>ClavimInit()

let s:plugin_path = escape(expand('<sfile>:p:h'), '\')

hi clavimMember  ctermbg=Cyan     ctermfg=Black  guibg=#8CCBEA    guifg=Black
hi clavimError   ctermbg=Red      ctermfg=Black  guibg=Red        guifg=Black

function! s:ClavimInit()
    python import sys
    python sys.argv[0] = ''
    exe 'python sys.path = ["' . s:plugin_path . '"] + sys.path'
    exe 'pyfile ' . s:plugin_path . '/clavim.py'
    set ut=10 " the time in milliseconds after a keystroke when you want to reparse the AST
    python global update
    python update = False
    call s:ClavimHighlightMemberExpressions()
    au CursorHold,CursorHoldI <buffer> call <SID>ClavimHighlightMemberExpressions()
    " au InsertChange,InsertEnter,InsertLeave <buffer> call <SID>ClavimHighlightMemberExpressions()
endfunction

function! s:ClavimHighlightMemberExpressions()
python << endpython

global update
global cursors

if update == True:
    vim.command("syn clear clavimMember")

cursors = []
cursors = find_cursors(get_current_translation_unit(update), clang.cindex.CursorKind.MEMBER_REF_EXPR)
for x in cursors:
    vim.command("syn match clavimMember /\\%"+str(x['line'])+"l\\%"+str(x['start'])+"c.*\\%"+str(x['end'])+"c/")

if update == False:
    update = True

endpython
endfunction

function! s:ClavimClearHighlights()
python << endpython
    global cursors
    for x in cursors:
        vim.command("syn clear clavimMember")
endpython
endfunction
