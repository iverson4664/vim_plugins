" ============================================================================
" full_typecheck_finished.vim
"
" File:          vimside#swank#event#full_typecheck_finished.vim
" Summary:       Vimside Event full-typecheck-finished
" Author:        Richard Emberson <richard.n.embersonATgmailDOTcom>
" Last Modified: 2012
"
" ============================================================================
" Intro: {{{1
"
" ============================================================================

let s:LOG = function("vimside#log#log")
let s:ERROR = function("vimside#log#error")


function! vimside#swank#event#full_typecheck_finished#Handle(...)
  if a:0 != 0
    call s:ERROR("vimside#swank#event#full_typecheck_finished#Handle: has additional args=". string(a:000))
  endif
  call s:LOG("full_typecheck_finished#Handle") 

  let entries = g:vimside.project.java_notes + g:vimside.project.scala_notes
  if len(entries) > 0
    call vimside#quickfix#Display(entries)
  else
    let msg = "Full Typecheck Finished..."
    call vimside#cmdline#Display(msg) 
  endif

endfunction
