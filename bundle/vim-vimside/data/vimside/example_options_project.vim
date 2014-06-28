" ============================================================================
" This file, example_options_project.vim will NOT be read by the Vimside 
" code. 
" To adjust option values, copy this file to a project directory,
" call the file the value of the Option:
" 'vimside-project-options-user-file-name'
" and add Option setter calls, e.g.:
"    call owner.Set("vimside-scala-version", "2.10.0")
"    call owner.Set("ensime-dist-dir", "ensime_2.10.0-SNAPSHOT-0.9.7")
"    call owner.Set("ensime-config-file-name", "_ensime")
" These Option values will be used to configure Vimside and can be
" project specific
" ============================================================================

" full path to this file
let s:full_path=expand('<sfile>:p')

" full path to this file's directory
let s:full_dir=fnamemodify(s:full_path, ':h')

function! g:VimsideOptionsProjectLoad(owner)
  let owner = a:owner

  " call owner.Set("ensime-log-enabled", 1)
  " call owner.Set("vimside-log-enabled", 1)

  " call owner.Update("vimside-scala-version", "2.10.0")
  " call owner.Update("ensime-dist-dir", "ensime_2.10.0-SNAPSHOT-0.9.7")
  " call owner.Update("ensime-config-file-name", "_ensime")

  " call owner.Set("forms-use", 1)

  " To use command line hover, disable (0) both
  " To use GVim hover, enable (1) balloon
  " To use Vim term hover, enable (1) term-balloon
  " call owner.Set("vimside-hover-balloon-enabled", 0)
  " call owner.Set("vimside-hover-term-balloon-enabled", 0)

endfunction

