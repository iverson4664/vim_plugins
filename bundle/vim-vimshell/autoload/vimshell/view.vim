"=============================================================================
" FILE: view.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu@gmail.com>
" Last Modified: 25 Nov 2013.
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! vimshell#view#_get_prompt(...) "{{{
  let line = get(a:000, 0, line('.'))
  let interactive = get(a:000, 1,
        \ (exists('b:interactive') ? b:interactive : {}))
  if empty(interactive)
    return ''
  endif

  if &filetype ==# 'vimshell' &&
        \ empty(b:vimshell.continuation)
    let context = vimshell#get_context()
    if context.prompt_expr != '' && context.prompt_pattern != ''
      return eval(context.prompt_expr)
    endif

    return context.prompt
  endif

  return vimshell#interactive#get_prompt(line, interactive)
endfunction"}}}
function! vimshell#view#_set_prompt_command(string) "{{{
  if !vimshell#check_prompt()
    " Search prompt.
    let [lnum, col] = searchpos(
          \ vimshell#get_context().prompt_pattern, 'bnW')
  else
    let lnum = '.'
  endif

  call setline(lnum, vimshell#get_prompt() . a:string)
endfunction"}}}
function! vimshell#view#_get_prompt_command(...) "{{{
  " Get command without prompt.
  if a:0 > 0
    return a:1[vimshell#get_prompt_length(a:1) :]
  endif

  if !vimshell#check_prompt()
    " Search prompt.
    let [lnum, col] = searchpos(
          \ vimshell#get_context().prompt_pattern, 'bnW')
  else
    let lnum = '.'
  endif
  let line = getline(lnum)[vimshell#get_prompt_length(getline(lnum)) :]

  let lnum += 1
  let secondary_prompt = vimshell#get_secondary_prompt()
  while lnum <= line('$') && !vimshell#check_prompt(lnum)
    if vimshell#view#_check_secondary_prompt(lnum)
      " Append secondary command.
      if line =~ '\\$'
        let line = substitute(line, '\\$', '', '')
      else
        let line .= "\<NL>"
      endif

      let line .= getline(lnum)[len(secondary_prompt):]
    endif

    let lnum += 1
  endwhile

  return line
endfunction"}}}
function! vimshell#view#_set_highlight() "{{{
  " Set syntax.
  let prompt_pattern = '/' .
        \ escape(vimshell#get_context().prompt_pattern, '/') . '/'
  let secondary_prompt_pattern = '/^' .
        \ escape(vimshell#util#escape_match(
        \ vimshell#get_secondary_prompt()), '/') . '/'
  execute 'syntax match vimshellPrompt'
        \ prompt_pattern 'nextgroup=vimshellCommand'
  execute 'syntax match vimshellPrompt'
        \ secondary_prompt_pattern 'nextgroup=vimshellCommand'
  syntax match   vimshellCommand '\f\+'
        \ nextgroup=vimshellLine contained
  syntax region vimshellLine start='' end='$' keepend contained
        \ contains=vimshellDirectory,vimshellConstants,
        \vimshellArguments,vimshellQuoted,vimshellString,
        \vimshellVariable,vimshellSpecial,vimshellComment
endfunction"}}}
function! vimshell#view#_close(buffer_name) "{{{
  let quit_winnr = vimshell#util#get_vimshell_winnr(a:buffer_name)
  if quit_winnr > 0
    " Hide unite buffer.
    silent execute quit_winnr 'wincmd w'

    if winnr('$') != 1
      close
    else
      call vimshell#util#alternate_buffer()
    endif
  endif

  return quit_winnr > 0
endfunction"}}}
function! vimshell#view#_print_prompt(...) "{{{
  if &filetype !=# 'vimshell' || line('.') != line('$')
        \ || !empty(b:vimshell.continuation)
    return
  endif

  " Save current directory.
  let b:vimshell.prompt_current_dir[s:get_prompt_linenr()] = getcwd()

  let context = a:0 >= 1? a:1 : vimshell#get_context()

  " Call preprompt hook.
  call vimshell#hook#call('preprompt', context, [])

  " Search prompt
  if empty(b:vimshell.commandline_stack)
    let new_prompt = vimshell#get_prompt()
  else
    let new_prompt = b:vimshell.commandline_stack[-1]
    call remove(b:vimshell.commandline_stack, -1)
  endif

  if vimshell#get_user_prompt() != '' ||
        \ vimshell#get_right_prompt() != ''
    " Insert user prompt line.
    call s:insert_user_and_right_prompt()
  endif

  " Insert prompt line.
  if getline('$') == ''
    call setline('$', new_prompt)
  else
    call append('$', new_prompt)
  endif

  $
  let &modified = 0
endfunction"}}}
function! vimshell#view#_print_secondary_prompt() "{{{
  if &filetype !=# 'vimshell' || line('.') != line('$')
    return
  endif

  " Insert secondary prompt line.
  call append('$', vimshell#get_secondary_prompt())
  $
  let &modified = 0
endfunction"}}}
function! vimshell#view#_start_insert(...) "{{{
  if &filetype !=# 'vimshell'
    return
  endif

  let is_insert = (a:0 == 0)? 1 : a:1

  if is_insert
    " Enter insert mode.
    $
    startinsert!

    call vimshell#helpers#imdisable()
  else
    normal! $
  endif
endfunction"}}}
function! vimshell#view#_cd(directory) "{{{
  let directory = fnameescape(a:directory)
  if vimshell#util#is_windows()
    " Substitute path sepatator.
    let directory = substitute(directory, '/', '\\', 'g')
  endif
  execute g:vimshell_cd_command directory

  if exists('*unite#sources#directory_mru#_append')
    " Append directory.
    call unite#sources#directory_mru#_append()
  endif
endfunction"}}}
function! vimshell#view#_next_prompt(context, ...) "{{{
  if &filetype !=# 'vimshell'
    return
  endif

  let is_insert = get(a:000, 0, get(a:context, 'is_insert', 1))

  if line('.') == line('$')
    call vimshell#print_prompt(a:context)
    call vimshell#start_insert(is_insert)
    return
  endif

  " Search prompt.
  call search(vimshell#get_context().prompt_pattern.'.\?', 'We')
  if is_insert
    if vimshell#view#_get_prompt_command() == ''
      startinsert!
    else
      normal! l
    endif
  endif

  stopinsert
endfunction"}}}

function! s:insert_user_and_right_prompt() "{{{
  let user_prompt = vimshell#get_user_prompt()
  if user_prompt != ''
    for user in split(eval(user_prompt), "\\n", 1)
      try
        let secondary = '[%] ' . user
      catch
        let message = v:exception . ' ' . v:throwpoint
        echohl WarningMsg | echomsg message | echohl None

        let secondary = '[%] '
      endtry

      if getline('$') == ''
        call setline('$', secondary)
      else
        call append('$', secondary)
      endif
    endfor
  endif

  " Insert right prompt line.
  if vimshell#get_right_prompt() == ''
    return
  endif

  try
    let right_prompt = eval(vimshell#get_right_prompt())
    let b:vimshell.right_prompt = right_prompt
  catch
    let message = v:exception . ' ' . v:throwpoint
    echohl WarningMsg | echomsg message | echohl None

    let right_prompt = ''
  endtry

  if right_prompt == ''
    return
  endif

  let user_prompt_last = (user_prompt != '') ?
        \   getline('$') : '[%] '
  let winwidth = (winwidth(0)+1)/2*2 - 5
  let padding_len =
        \ (len(user_prompt_last)+len(vimshell#get_right_prompt())+1
        \          > winwidth) ?
        \ 1 : winwidth - (len(user_prompt_last)+len(right_prompt))
  let secondary = printf('%s%s%s', user_prompt_last,
        \ repeat(' ', padding_len), right_prompt)
  if getline('$') == '' || vimshell#get_user_prompt() != ''
    call setline('$', secondary)
  else
    call append('$', secondary)
  endif

  let prompts_save = {}
  let prompts_save.right_prompt = right_prompt
  let prompts_save.user_prompt_last = user_prompt_last
  let prompts_save.winwidth = winwidth
  let b:vimshell.prompts_save[line('$')] = prompts_save
endfunction"}}}

function! vimshell#view#_check_prompt(...) "{{{
  if &filetype !=# 'vimshell' || !empty(b:vimshell.continuation)
    return call('vimshell#get_prompt', a:000) != ''
  endif

  let line = a:0 == 0 ? getline('.') : getline(a:1)
  return line =~# vimshell#get_context().prompt_pattern
endfunction"}}}
function! vimshell#view#_check_secondary_prompt(...) "{{{
  let line = a:0 == 0 ? getline('.') : getline(a:1)
  return vimshell#util#head_match(line, vimshell#get_secondary_prompt())
endfunction"}}}
function! vimshell#view#_check_user_prompt(...) "{{{
  let line = a:0 == 0 ? line('.') : a:1
  if !vimshell#util#head_match(getline(line-1), '[%] ')
    " Not found.
    return 0
  endif

  while 1
    let line -= 1

    if !vimshell#util#head_match(getline(line-1), '[%] ')
      break
    endif
  endwhile

  return line
endfunction"}}}

function! s:get_prompt_linenr() "{{{
  if b:interactive.type !=# 'interactive'
        \ && b:interactive.type !=# 'vimshell'
    return 0
  endif

  let [line, col] = searchpos(
        \ vimshell#get_context().prompt_pattern, 'nbcW')
  return line
endfunction"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
