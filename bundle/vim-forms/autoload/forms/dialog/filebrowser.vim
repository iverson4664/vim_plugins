
" ------------------------------------------------------------ 
" forms#dialog#filebrowser#Make:
"  A form to browse file system and select file.
"    The form has: 
"      Label (title)
"      VariableLengthField (file name)
"      SelectList 
"      Cancel and Open buttons
"    Example:
"       ┌───────────────────────────┐
"       │        File Browser       │
"       ├───────────────────────────┤
"       │┌─────────────────────────┐│
"       ││                         ││
"       │└─────────────────────────┘│
"       │┌─────────────────┐        │
"       ││../              │        │
"       ││build/           │        │
"       ││examples/        │        │
"       ││extra/           │        │
"       ││ivy/             │        │
"       ││lib/             │        │
"       ││other/           │        │
"       ││src/             │        │
"       ││tmp/             │        │
"       ││EnsimeClient.log │        │
"       │└─────────────────┘        │
"       │                Cancel Open│
"       └───────────────────────────┘
"
"  parameters:
"     attrs: optional Dictionary
"             title: title (default File Browser)
"             dir: initial directory (default cwdir)
" ------------------------------------------------------------ 
" map <Leader>v7 :call forms#dialog#filebrowser#Make()<CR>
" forms#dialog#filebrowser#Make: {{{1
function! forms#dialog#filebrowser#Make(...) 

  function! FBMakeChoices(dir) 
    let files = split(globpath(a:dir, "*"), '\n')
    let flist = []
    let dlist = [["../", 0]]
    let cnt = 1
    for file in files
      let index = strridx(file, '/')+1
      let filename = strpart(file, index, len(file)-index)
      if isdirectory(file)
        call add(dlist, [filename.'/', cnt])
      else
        call add(flist, [filename, cnt])
      endif

      let cnt += 1
    endfor
    return dlist + flist
  endfunction

  let title = 'File Browser'
  let initial_dir = getcwd()
  if a:0 != 0
    if ! type(a:1) == g:self#DICTIONARY_TYPE
      throw "Error: forms#dialog#filebrowser#Make bad argument type: " .string(a:1)
    endif
    let dict = a:1
    if has_key(dict, 'title')
      let title = dict['title']
    endif
    if has_key(dict, 'dir')
      let initial_dir = dict['dir']
    endif
  endif

  let attrs = { 'text': title }
  let titleLabel = forms#newLabel(attrs)

  function! FBVLFAction(...) dict
    call self.acceptbutton.doSelect()
  endfunction
  let fnaction = forms#newAction({ 'execute': function("FBVLFAction")})

  let esize = 25
  let fn = forms#newVariableLengthField({
                                       \ 'tag': 'editor',
                                       \ 'size': esize,
                                       \ 'on_selection_action': fnaction
                                       \ })
  function! fn.purpose() dict
    return [
        \ "Use editor ot enter a filename.",
        \ "  Enter <CR> to accept the entered filename."
        \ ]
  endfunction
  let fnbox = forms#newBox({'body': fn})

  function! FBAction(...) dict
    let slist = self.slist
    let pos = slist.__selections[0][0]
" call forms#log("FBAction.execute: pos=".pos)
    let [filename,_] = slist.__choices[pos]
    if strpart(filename, len(filename)-1, 1) == '/'
" call forms#log("FBAction.execute: directory: ".filename)
      call self.fn.setText('')

      let dir = self.dir
" call forms#log("FBAction.execute: old dir: ".dir)
      let dir = simplify(dir . '/' . filename)
      let self.dir = dir
" call forms#log("FBAction.execute: new dir: ".dir)

      let choices = FBMakeChoices(dir) 
      let attrs = { 
            \ 'tag': 'selection',
            \ 'mode': 'single',
            \ 'pos': 0,
            \ 'choices': choices,
            \ 'size': slist.__size,
            \ 'on_selection_action': self
          \ }
" call forms#log("FBAction.execute: before reinit")
      call slist.reinit(attrs)
" call forms#log("FBAction.execute: after reinit")

    else
" call forms#log("FBAction.execute: file: ".filename)
      call self.fn.setText(filename)
    endif
  endfunction
  let fbaction = forms#newAction({ 'execute': function("FBAction")})
  let fbaction.fn = fn

  let choices = FBMakeChoices(initial_dir) 

  " SelectList
  let ssize = 10
  let attrs = { 
          \ 'tag': 'selection',
          \ 'mode': 'single',
          \ 'choices': choices,
          \ 'size': ssize,
          \ 'on_selection_action': fbaction
          \ }
  let slist = forms#newSelectList(attrs)
  function! slist.purpose() dict
    return [
        \ "Navigate file system with select list.",
        \ "  Select ../ to move up a directory. Select a directory",
        \ "  name to enter that directory, Select a file to enter",
        \ "  the file into the editor."
        \ ]
  endfunction
  let fbaction.slist = slist
  let fbaction.dir = initial_dir
  let slistbox = forms#newBox({ 'body': slist} )
  
  " Bottom HPoly
  let hspaceB = forms#newHSpace({'size': 1})

  let attrs = { 'text': 'Cancel'}
  let cancellabel = forms#newLabel(attrs)
  let cancelbutton = forms#newButton({
                              \ 'tag': 'cancel', 
                              \ 'body': cancellabel, 
                              \ 'action': g:forms#cancelAction})
  function! cancelbutton.purpose() dict
    return [
        \ "Make no selection, cancel operation."
        \ ]
  endfunction
  let attrs = { 'text': 'Accept'}
  let acceptlabel = forms#newLabel(attrs)
  let acceptbutton = forms#newButton({
                              \ 'tag': 'accept', 
                              \ 'body': acceptlabel, 
                              \ 'action': g:forms#submitAction})
  function! acceptbutton.purpose() dict
    return [
        \ "Accept the filename in the editor."
        \ ]
  endfunction
  let fnaction.acceptbutton = acceptbutton

  let hpoly = forms#newHPoly({'children': [
                                \ cancelbutton, 
                                \ hspaceB, 
                                \ acceptbutton] })

  let vpoly = forms#newVPoly({'children': [
                                \ fnbox, 
                                \ slistbox, 
                                \ hpoly],
                                \ 'alignments': [[2,'R']]
                                \ })
  let topvpoly = forms#newVPoly({'children': [
                                \ titleLabel, 
                                \ vpoly],
                                \ 'mode': 'light',
                                \ 'alignment': 'C'
                                \ })

  " let b = forms#newBorder({ 'body': vpoly })
  let bg = forms#newBackground({ 'body': topvpoly })
  let form = forms#newForm({'body': bg })
  function! form.purpose() dict
    return [
        \ "Navigate the file system and select a file.",
        \ "  Use editor to enter a filename or the select list",
        \ "  to navigate the file system and make a file selection.",
        \ "  Press Cancel to make no selection.",
        \ "  Press Open to make file selection."
        \ ]
  endfunction
  let results = form.run()
  if type(results) == g:self#DICTIONARY_TYPE
    if results.accept 
      let rval = fbaction.dir . '/' . results.editor
      return rval
    endif
  endif
  return ''
endfunction

" forms#dialog#filebrowser#MakeTest: {{{1
function! forms#dialog#filebrowser#MakeTest() 
  call forms#AppendInput({'type': 'Sleep', 'time': 5})
  call forms#AppendInput({'type': 'Exit'})
  call forms#dialog#filebrowser#Make() 
endfunction

"  Modelines: {{{1
" ================
" vim: ts=4 fdm=marker
