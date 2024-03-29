"
" happy's Vim Configuration

" Get pathogen up and running
filetype off

 " To disable a plugin, add it's bundle name to the following list
 let g:pathogen_disabled = [
    \ 'vim-blogit',
    \ 'vim-bufkill',
    \ 'vim-doxgen',
    \ 'vim-easymotion1.0',
    \ 'vim-easyclip',
    \ 'vim-forms',
    \ 'vim-fswitch',
    \ 'vim-fuzzyfinder',
    \ 'vim-gnupg',
    \ 'vim-indentLine',
    \ 'vim-jade',
    \ 'vim-json',
    \ 'vim-l9',
    \ 'vim-leaderf',
    \ 'vim-mwutils',
    \ 'vim-neocomplcache-clang',
    \ 'vim-neocomplcache',
    \ 'vim-orgmode',
    \ 'vim-sbt',
    \ 'vim-scala',
    \ 'vim-self',
    \ 'vim-taglist',
    \ 'vim-textobjline',
    \ 'vim-textobjuser',
    \ 'vim-twitvim',
    \ 'vim-ultisnips',
    \ ]
 if v:version < '703584'
     call add(g:pathogen_disabled, 'YouCompleteMe')
 endif
 execute pathogen#infect()
"happy marked call pathogen#runtime_append_all_bundles()

call pathogen#helptags()

" Add xptemplate global personal directory value
if has("unix")
  set runtimepath+=~/.vim/xpt-personal
endif

" Set filetype stuff to on
set nocp
filetype on
filetype plugin on
filetype indent on

" Tabstops are 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" move to after/ftplugin/c.vim
" if has("autocmd")
"     au! FileType c setl noexpandtab
" endif

" Printing options
set printoptions=header:0,duplex:long,paper:letter

" set the search scan to wrap lines
set nowrapscan

set ignorecase

" set the forward slash to be the slash of note.  Backslashes suck
set shellslash
if has("unix")
  set shell=bash
else
  set shell=ksh.exe
endif

" Make command line a line high
set ch=1 " cmdheight

" Allow backspacing over indent, eol, and the start of an insert
set backspace=2

" Make sure that unsaved buffers that are to be put in the background are 
" allowed to go in there (ie. the "must save first" error doesn't come up)
" set hidden

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions=ces$

" Set the status line the way i like it
set stl=%f\ %m\ %r%{fugitive#statusline()}\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" Don't update the display while executing macros
set lazyredraw

" Don't show the current command int he lower right corner.  In OSX, if this is
" set and lazyredraw is set then it's slow as molasses, so we unset this
set showcmd

" Show the current mode
set showmode

" Switch on syntax highlighting.
syntax on

" Hide the mouse pointer while typing
set mousehide

" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" set the gui options the way I like
set guioptions=acg

" Setting this below makes it sow that error messages don't disappear after one second on startup.
"set debug=msg

" This is the timeout used while waiting for user input on a multi-keyed macro
" or while just sitting and waiting for another key to be pressed measured
" in milliseconds.
"
" i.e. for the ",d" command, there is a "timeoutlen" wait period between the
"      "," key and the "d" key.  If the "d" key isn't pressed before the
"      timeout expires, one of two things happens: The "," command is executed
"      if there is one (which there isn't) or the command aborts.
set timeoutlen=500

" Keep some stuff in the history
set history=512

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Allow the cursor to go in to "invalid" places
"set virtualedit=all

" Disable encryption (:X)
set key=

" Make the command-line completion better
set wildmenu

" Same as default except that I remove the 'u' option
set complete=.,w,b,t

" When completing by tag, show the whole tag, not just the function name
set showfulltag

" Set the textwidth to be 80 chars
set textwidth=80

" get rid of the silly characters in separators
" set fillchars = ""

" Add ignorance of whitespace to diff
set diffopt+=iwhite

" Enable search highlighting
set hlsearch
set nowrap
set number
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
"
" colorscheme jellybeans
" colorscheme Tomorrow-Night-Eighties
colorscheme molokai
" colorscheme obsidian
" colorscheme solarized

"nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>

let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 48
"set foldmethod=syntax
let g:clang_complete_auto = 1
let g:clang_complete_copen = 1
let g:clang_close_preview=1
" let g:clang_library_path="/usr/lib/clang/clang-3.2"
let g:clang_library_path = $HOME . "/.vim-env/lib/clang-3.2"
" Incrementally match the search
set incsearch


" Add the unnamed register to the clipboard
set clipboard+=unnamed

" Automatically read a file that has changed on disk
set autoread

set grepprg=grep\ -nH\ $*

set relativenumber

" Let the syntax highlighting for Java files allow cpp keywords
let java_allow_cpp_keywords = 1

" System default for mappings is now the "," character
let mapleader = ","

" Wipe out all buffers
" nmap <silent> ,wa :1,9000bwipeout<cr>

" Toggle paste mode
nmap <silent> ,p :set invpaste<CR>:set paste?<CR>

" cd to the directory containing the file in the buffer
" nmap <silent> ,cd :lcd %:h<CR>
" nmap <silent> ,md :!mkdir -p %:p:h<CR>

" Turn off that stupid highlight search
nmap <silent> ,n :nohls<CR>

" put the vim directives for my file editing settings in
" nmap <silent> ,vi ovim:set ts=2 sts=2 sw=2:<CR>vim600:fdm=marker fdl=1 fdc=0:<ESC>

" Show all available VIM servers
" nmap <silent> ,ss :echo serverlist()<CR>

" The following beast is something i didn't write... it will return the 
" syntax highlighting group that the current "thing" under the cursor
" belongs to -- very useful for figuring out what to change as far as 
" syntax highlighting goes.
" nmap <silent> ,qq :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" set text wrapping toggles
" nmap <silent> ,ww :set invwrap<CR>:set wrap?<CR>

" allow command line editing like emacs
" cnoremap <C-A>      <Home>
" cnoremap <C-B>      <Left>
" cnoremap <C-E>      <End>
" cnoremap <C-F>      <Right>
" cnoremap <C-N>      <End>
" cnoremap <C-P>      <Up>
" cnoremap <ESC>b     <S-Left>
" cnoremap <ESC><C-B> <S-Left>
" cnoremap <ESC>f     <S-Right>
" cnoremap <ESC><C-F> <S-Right>
" cnoremap <ESC><C-H> <C-W>

" Maps to make handling windows a bit easier
" noremap <silent> ,h :wincmd h<CR>
" noremap <silent> ,j :wincmd j<CR>
" noremap <silent> ,k :wincmd k<CR>
" noremap <silent> ,l :wincmd l<CR>
" noremap <silent> ,sb :wincmd p<CR>
" noremap <silent> <C-F9>  :vertical resize -10<CR>
" noremap <silent> <C-F10> :resize +10<CR>
" noremap <silent> <C-F11> :resize -10<CR>
" noremap <silent> <C-F12> :vertical resize +10<CR>
" noremap <silent> ,s8 :vertical resize 83<CR>
" noremap <silent> ,cj :wincmd j<CR>:close<CR>
" noremap <silent> ,ck :wincmd k<CR>:close<CR>
" noremap <silent> ,ch :wincmd h<CR>:close<CR>
" noremap <silent> ,cl :wincmd l<CR>:close<CR>
" noremap <silent> ,cc :close<CR>
" noremap <silent> ,cw :cclose<CR>
" noremap <silent> ,ml <C-W>L
" noremap <silent> ,mk <C-W>K
" noremap <silent> ,mh <C-W>H
" noremap <silent> ,mj <C-W>J
" noremap <silent> <C-7> <C-W>>
" noremap <silent> <C-8> <C-W>+
" noremap <silent> <C-9> <C-W>+
" noremap <silent> <C-0> <C-W>>

" Edit the vimrc file
nmap <silent> ,ev :e $MYVIMRC<CR>
nmap <silent> ,sv :so $MYVIMRC<CR>

" Make horizontal scrolling easier
" nmap <silent> <C-o> 10zl
" nmap <silent> <C-i> 10zh

" Add a GUID to the current line
" imap <C-J>d <C-r>=substitute(system("uuidgen"), '.$', '', 'g')<CR>

" Toggle fullscreen mode
" nmap <silent> <F3> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

" Underline the current line with '='
" nmap <silent> ,u= :t.\|s/./=/g\|:nohls<cr>
" nmap <silent> ,u- :t.\|s/./-/g\|:nohls<cr>
" nmap <silent> ,u~ :t.\|s/./\\~/g\|:nohls<cr>

" Shrink the current window to fit the number of lines in the buffer.  Useful
" for those buffers that are only a few lines
" nmap <silent> ,sw :execute ":resize " . line('$')<cr>

" Use the bufkill plugin to eliminate a buffer but keep the window layout
" nmap ,bd :BD<cr>

" Use CTRL-E to replace the original ',' mapping
" nnoremap <C-E> ,

" Alright... let's try this out
" inoremap jj <esc>
" inoremap JJ <esc>
" cnoremap jj <esc>

" I like jj - Let's try something else fun
" imap ,fn <c-r>=expand('%:t:r')<cr>

" Clear the text using a motion / text object and then move the character to the
" next word
" nmap <silent> ,C :set opfunc=ClearText<CR>g@
" vmap <silent> ,C :<C-U>call ClearText(visual(), 1)<CR>

" Make the current file executable
" nmap ,x :w<cr>:!chmod 755 %<cr>:e<cr>

" Digraphs
" Alpha
" imap <c-l><c-a> <c-k>a*
" Beta
" imap <c-l><c-b> <c-k>b*
" Gamma
" imap <c-l><c-g> <c-k>g*
" Delta
" imap <c-l><c-d> <c-k>d*
" Epslion
" imap <c-l><c-e> <c-k>e*
" Lambda
" imap <c-l><c-l> <c-k>l*
" Eta
" imap <c-l><c-y> <c-k>y*
" Theta
" imap <c-l><c-h> <c-k>h*
" Mu
" imap <c-l><c-m> <c-k>m*
" Rho
" imap <c-l><c-r> <c-k>r*
" Pi
" imap <c-l><c-p> <c-k>p*
" Phi
" imap <c-l><c-f> <c-k>f*

" function! ClearText(type, ...)
" 	let sel_save = &selection
" 	let &selection = "inclusive"
" 	let reg_save = @@
" 	if a:0 " Invoked from Visual mode, use '< and '> marks
" 		silent exe "normal! '<" . a:type . "'>r w"
" 	elseif a:type == 'line'
" 		silent exe "normal! '[V']r w"
" 	elseif a:type == 'line'
" 		silent exe "normal! '[V']r w"
"     elseif a:type == 'block'
"       silent exe "normal! `[\<C-V>`]r w"
"     else
"       silent exe "normal! `[v`]r w"
"     endif
"     let &selection = sel_save
"     let @@ = reg_save
" endfunction

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

" Highlight the current line and column
" Don't do this - It makes window redraws painfully slow
set nocursorline
set nocursorcolumn

" if has("mac")
"   let g:main_font = "Anonymous\\ Pro:h12"
"   let g:small_font = "Anonymous\\ Pro:h2"
" else
"   let g:main_font = "DejaVu\\ Sans\\ Mono\\ 9"
"   let g:small_font = "DejaVu\\ Sans\\ Mono\\ 2"
" endif

"-----------------------------------------------------------------------------
" Fugitive
"-----------------------------------------------------------------------------
" Thanks to Drew Neil
" autocmd User fugitive
"   \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
"   \  noremap <buffer> .. :edit %:h<cr> |
"   \ endif
" autocmd BufReadPost fugitive://* set bufhidden=delete

" nmap ,gs :Gstatus<cr>
" nmap ,ge :Gedit<cr>
" nmap ,gw :Gwrite<cr>
" nmap ,gr :Gread<cr>

"-----------------------------------------------------------------------------
" NERD Tree Plugin Settings
"-----------------------------------------------------------------------------
" Toggle the NERD Tree on an off with F7
nmap <silent> ,nf :NERDTreeFind<CR>
nmap <silent> <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
" nmap <S-F7> :NERDTreeClose<CR>

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
                   \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
                   \ '\.embed\.manifest$', '\.embed\.manifest.res$',
                   \ '\.intermediate\.manifest$', '^mt.dep$',
                   \ 'cscope\.files', 'cscope\.in\.out', 'cscope\.po\.out', 'cscope\.out', 
                   \ '.*\.o$' ]
" happy don't ignore '.vim.*$', 'tags', '\.tag.*$',

"-----------------------------------------------------------------------------
" GPG Stuff
"-----------------------------------------------------------------------------
" if has("mac")
"     let g:GPGExecutable = "gpg2"
"     let g:GPGUseAgent = 0
" endif

"-----------------------------------------------------------------------------
" L9 mappings
"-----------------------------------------------------------------------------
" L9 creates an 'interesting' set of error formats when quickfix is engaged
" This mapping cleans it up
" nmap <silent> ,eu :sign unplace *<cr>

"-----------------------------------------------------------------------------
" FSwitch mappings
"-----------------------------------------------------------------------------
" nmap <silent> ,of :FSHere<CR>
" nmap <silent> ,ol :FSRight<CR>
" nmap <silent> ,oL :FSSplitRight<CR>
" nmap <silent> ,oh :FSLeft<CR>
" nmap <silent> ,oH :FSSplitLeft<CR>
" nmap <silent> ,ok :FSAbove<CR>
" nmap <silent> ,oK :FSSplitAbove<CR>
" nmap <silent> ,oj :FSBelow<CR>
" nmap <silent> ,oJ :FSSplitBelow<CR>

"-----------------------------------------------------------------------------
" XPTemplate settings
"-----------------------------------------------------------------------------
let g:xptemplate_brace_complete = ''

"-----------------------------------------------------------------------------
" TwitVim settings
"-----------------------------------------------------------------------------
" let twitvim_enable_perl = 1
" let twitvim_browser_cmd = 'firefox'
" nmap ,tw :FriendsTwitter<cr>
" nmap ,tm :UserTwitter<cr>
" nmap ,tM :MentionsTwitter<cr>
" function! TwitVimMappings()
"     nmap <buffer> U :exe ":UnfollowTwitter " . expand("<cword>")<cr>
"     nmap <buffer> F :exe ":FollowTwitter " . expand("<cword>")<cr>
"     nmap <buffer> 7 :BackTwitter<cr>
"     nmap <buffer> 8 :ForwardTwitter<cr>
"     nmap <buffer> 1 :PreviousTwitter<cr>
"     nmap <buffer> 2 :NextTwitter<cr>
"     nmap <buffer> ,sf :SearchTwitter #scala OR #akka<cr>
"     nmap <buffer> ,ss :SearchTwitter #scala<cr>
"     nmap <buffer> ,sa :SearchTwitter #akka<cr>
"     nmap <buffer> ,sv :SearchTwitter #vim<cr>
" endfunction
" augroup derek_twitvim
"     au!
"     au FileType twitvim call TwitVimMappings()
" augroup END

"-----------------------------------------------------------------------------
" VimSokoban settings
"-----------------------------------------------------------------------------
" Sokoban stuff
" let g:SokobanLevelDirectory = "/home/dwyatt/.vim/bundle/vim-sokoban/VimSokoban/"

"-----------------------------------------------------------------------------
" FuzzyFinder Settings
"-----------------------------------------------------------------------------
"let g:fuf_file_exclude .= '|/$|/target/'
" let g:fuf_splitPathMatching = 1
" let g:fuf_maxMenuWidth = 110
" let g:fuf_timeFormat = ''
" nmap <silent> ,fv :FufFile ~/.vim/<cr>
" nmap <silent> ,fc :FufMruCmd<cr>
" nmap <silent> ,fm :FufMruFile<cr>

" function! GetParentOfSourceDirectory()
"   let fwd = expand('%:p:h')
"   let srcparent = substitute(fwd, '/[^/]*/src/.*', '', '')
"   return srcparent
" endfunction

" function! GetFufProjectRoot(from)
"   let dir = split(a:from, "/")
"   let found = 0
"   while found == 0 && len(dir) != 0
"     let tempdir = "/" . join(dir, "/")
"     if filereadable(tempdir . "/.fuf.project.root")
"       return tempdir
"     endif
"     let dir = dir[0:-2]
"   endwhile
"   echoerr "Unable to locate project root (can't find .fuf.project.root file)"
"   return ""
" endfunction

" set wildignore+=*.o,*.class,.git,.svn
" let g:CommandTMatchWindowAtTop = 1
" let g:make_scala_fuf_mappings = 0
" nmap <silent> ,fb :FufBuffer<cr>
" nmap <silent> ,ft :FufTag<cr>
" nmap <silent> ,ff :let targetFufDirectory=expand('%:p:h')<cr>:cd <c-r>=GetFufProjectRoot(expand('%:p:h'))<cr><cr>:FufFile <c-r>=targetFufDirectory<cr>/**/<cr>
" nmap <silent> ,fs :exec ":FufFile " . GetParentOfSourceDirectory() . "/**/"<cr>
" nmap <silent> ,fr :cd <c-r>=GetFufProjectRoot(expand('%:p:h'))<cr><cr>:FufFile **/<cr>

"-----------------------------------------------------------------------------
" SVN Helpers
"-----------------------------------------------------------------------------
" function! VCSDiffMore(from)
"   let f = expand('%:p')
"   let revisions = split(system("svn log " . f . " | grep '^r[0-9][0-9]*'"), '\n')
"   let revisions = map(revisions, 'substitute(v:val, "r\\(\\d\\+\\) .*$", "\\1", "")')
"   exec ":VCSVimDiff " . revisions[a:from]
" endfunction
"happy removed nmap ,dd :call VCSDiffMore(0)<cr>
"function! ShowSVNRevisions()
"  let f = expand('%:p')
"  let revisions = system("svn log " . f)
"  let buffer = bufnr('%')
"endfunction

"-----------------------------------------------------------------------------
" Gundo Settings
"-----------------------------------------------------------------------------
" nmap <c-F5> :GundoToggle<cr>

"-----------------------------------------------------------------------------
" Conque Settings
"-----------------------------------------------------------------------------
" let g:ConqueTerm_FastMode = 1
" let g:ConqueTerm_ReadUnfocused = 1
" let g:ConqueTerm_InsertOnEnter = 1
" let g:ConqueTerm_PromptRegex = '^-->'
" let g:ConqueTerm_TERM = 'xterm'

"-----------------------------------------------------------------------------
" Functions
"-----------------------------------------------------------------------------
" if !exists('g:bufferJumpList')
"   let g:bufferJumpList = {}
" endif

" function! MarkBufferInJumpList(bufstr, letter)
"   let g:bufferJumpList[a:letter] = a:bufstr
" endfunction

" function! JumpToBufferInJumpList(letter)
"   if has_key(g:bufferJumpList, a:letter)
"     exe ":buffer " . g:bufferJumpList[a:letter]
"   else
"     echoerr a:letter . " isn't mapped to any existing buffer"
"   endif
" endfunction

" function! ListJumpToBuffers()
"   for key in keys(g:bufferJumpList)
"     echo key . " = " . g:bufferJumpList[key]
"   endfor
" endfunction

" function! IndentToNextBraceInLineAbove()
"   :normal 0wk
"   :normal "vyf(
"   let @v = substitute(@v, '.', ' ', 'g')
"   :normal j"vPl
" endfunction

" nmap <silent> ,ii :call IndentToNextBraceInLineAbove()<cr>

" nmap <silent> ,mba :call MarkBufferInJumpList(expand('%:p'), 'a')<cr>
" nmap <silent> ,mbb :call MarkBufferInJumpList(expand('%:p'), 'b')<cr>
" nmap <silent> ,mbc :call MarkBufferInJumpList(expand('%:p'), 'c')<cr>
" nmap <silent> ,mbd :call MarkBufferInJumpList(expand('%:p'), 'd')<cr>
" nmap <silent> ,mbe :call MarkBufferInJumpList(expand('%:p'), 'e')<cr>
" nmap <silent> ,mbf :call MarkBufferInJumpList(expand('%:p'), 'f')<cr>
" nmap <silent> ,mbg :call MarkBufferInJumpList(expand('%:p'), 'g')<cr>
" nmap <silent> ,jba :call JumpToBufferInJumpList('a')<cr>
" nmap <silent> ,jbb :call JumpToBufferInJumpList('b')<cr>
" nmap <silent> ,jbc :call JumpToBufferInJumpList('c')<cr>
" nmap <silent> ,jbd :call JumpToBufferInJumpList('d')<cr>
" nmap <silent> ,jbe :call JumpToBufferInJumpList('e')<cr>
" nmap <silent> ,jbf :call JumpToBufferInJumpList('f')<cr>
" nmap <silent> ,jbg :call JumpToBufferInJumpList('g')<cr>
" nmap <silent> ,ljb :call ListJumpToBuffers()<cr>

" function! DiffCurrentFileAgainstAnother(snipoff, replacewith)
"   let currentFile = expand('%:p')
"   let otherfile = substitute(currentFile, "^" . a:snipoff, a:replacewith, '')
"   only
"   execute "vertical diffsplit " . otherfile
" endfunction

" command! -nargs=+ DiffCurrent call DiffCurrentFileAgainstAnother(<f-args>)

" function! RunSystemCall(systemcall)
"   let output = system(a:systemcall)
"   let output = substitute(output, "\n", '', 'g')
"   return output
" endfunction

" function! HighlightAllOfWord(onoff)
"   if a:onoff == 1
"     :augroup highlight_all
"     :au!
"     :au CursorMoved * silent! exe printf('match Search /\<%s\>/', expand('<cword>'))
"     :augroup END
"   else
"     :au! highlight_all
"     match none /\<%s\>/
"   endif
" endfunction

" :nmap ,ha :call HighlightAllOfWord(1)<cr>
" :nmap ,hA :call HighlightAllOfWord(0)<cr>

" function! LengthenCWD()
"   let cwd = getcwd()
"   if cwd == '/'
"     return
"   endif
"   let lengthend = substitute(cwd, '/[^/]*$', '', '')
"   if lengthend == ''
"     let lengthend = '/'
"   endif
"   if cwd != lengthend
"     exec ":lcd " . lengthend
"   endif
" endfunction

" :nmap ,ld :call LengthenCWD()<cr>

" function! ShortenCWD()
"   let cwd = split(getcwd(), '/')
"   let filedir = split(expand("%:p:h"), '/')
"   let i = 0
"   let newdir = ""
"   while i < len(filedir)
"     let newdir = newdir . "/" . filedir[i]
"     if len(cwd) == i || filedir[i] != cwd[i]
"       break
"     endif
"     let i = i + 1
"   endwhile
"   exec ":lcd /" . newdir
" endfunction

" :nmap ,sd :call ShortenCWD()<cr>

" function! RedirToYankRegisterF(cmd, ...)
"   let cmd = a:cmd . " " . join(a:000, " ")
"   redir @*>
"   exe cmd
"   redir END
" endfunction

" command! -complete=command -nargs=+ RedirToYankRegister
"       \ silent! call RedirToYankRegisterF(<f-args>)

" function! ToggleMinimap()
"   if exists("s:isMini") && s:isMini == 0
"     let s:isMini = 1
"   else
"     let s:isMini = 0
"   end

"   if (s:isMini == 0)
"     " save current visible lines
"     let s:firstLine = line("w0")
"     let s:lastLine = line("w$")

"     " make font small
"     exe "set guifont=" . g:small_font
"     " highlight lines which were visible
"     let s:lines = ""
"     for i in range(s:firstLine, s:lastLine)
"       let s:lines = s:lines . "\\%" . i . "l"

"       if i < s:lastLine
"         let s:lines = s:lines . "\\|"
"       endif
"     endfor

"     exe 'match Visible /' . s:lines . '/'
"     hi Visible guibg=lightblue guifg=black term=bold
"     nmap <s-j> 10j
"     nmap <s-k> 10k
"   else
"     exe "set guifont=" . g:main_font
"     hi clear Visible
"     nunmap <s-j>
"     nunmap <s-k>
"   endif
" endfunction

" command! ToggleMinimap call ToggleMinimap()

" I /literally/ never use this and it's pissing me off
" nnoremap <space> :ToggleMinimap<CR>

"-----------------------------------------------------------------------------
" Commands
"-----------------------------------------------------------------------------
" function! FreemindToListF()
"   setl filetype=
"   silent! :%s/^\(\s*\).*TEXT="\([^"]*\)".*$/\1- \2/
"   silent! :g/^\s*</d
"   silent! :%s/&quot;/"/g
"   silent! :%s/&apos;/\'/g
"   silent! g/^-/s/- //
"   silent! g/^\w/t.|s/./=/g
"   silent! g/^\s*-/normal O
"   silent! normal 3GgqG
"   silent! %s/^\s\{4}\zs-/o/
"   silent! %s/^\s\{12}\zs-/+/
"   silent! %s/^\s\{16}\zs-/*/
"   silent! %s/^\s\{20}\zs-/#/
"   silent! normal gg
" endfunction

" command! FreemindToList call FreemindToListF()

"-----------------------------------------------------------------------------
" Auto commands
"-----------------------------------------------------------------------------
augroup derek_xsd
  au!
  au BufEnter *.xsd,*.wsdl,*.xml setl tabstop=4 shiftwidth=4
  au BufEnter *.xsd,*.wsdl,*.xml setl formatoptions=crq textwidth=120 colorcolumn=120
augroup END

augroup Binary
  au!
  au BufReadPre   *.bin let &bin=1
  au BufReadPost  *.bin if &bin | %!xxd
  au BufReadPost  *.bin set filetype=xxd | endif
  au BufWritePre  *.bin if &bin | %!xxd -r
  au BufWritePre  *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

" if has("gui_running")
"   exe "set guifont=" . g:main_font
"   "if hostname() == "dqw-linux"
"   "  set background=light
"   "else
"   "  set background=dark
"   "endif
"   colorscheme xoria256
"   if !exists("g:vimrcloaded")
"     winpos 0 0
"     if !&diff
"       winsize 130 120
"     else
"       winsize 227 120
"     endif
"     let g:vimrcloaded = 1
"   endif
" endif
" :nohls

set cursorline
" hi  CursorLine  guibg=Grey40 guifg=red term=BOLD
set cursorcolumn
" hi  CursorColumn  guibg=Grey40 guifg=red term=BOLD

" set encoding=utf-8
set t_Co=256
let g:Powerline_symbols= "fancy"
set fillchars+=stl:\ ,stlnc:\ ,

if has('gui')
    set guioptions-=e
endif
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let s .= i . ':'
            let s .= winnr . '/' . tabpagewinnr(i,'$')
            let s .= ' %*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= file
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    map    <C-Tab>    :tabnext<CR>
    imap   <C-Tab>    <C-O>:tabnext<CR>
    map    <C-S-Tab>  :tabprev<CR>
    imap   <C-S-Tab>  <C-O>:tabprev<CR>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"happy added start

let g:cscope_enhanced_edition = matchstr(system("cscope"), 'enhanced edition') != ''

" disable F1&L/R window built-in help key
map <F1> <Nop>

set ttimeoutlen=50
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,ucs-bom,gbk,cp936,gb2312,gb18030

" map alt key start
let g:altDedicatedKeyMap = {
            \'n': {
                \ '<M-h>':  ['5h'],
                \ '<M-j>':  ['5j'],
                \ '<M-k>':  ['5k'],
                \ '<M-l>':  ['5l'],
                \ '<M-w>':  ['5w'],
                \ '<M-e>':  ['5e'],
                \ '<M-b>':  ['5b'],
                \ '<M-g>e': ['5ge'],
            \ },
            \'v': {
                \ '<M-h>':  ['5h'],
                \ '<M-j>':  ['5j'],
                \ '<M-k>':  ['5k'],
                \ '<M-l>':  ['5l'],
                \ '<M-w>':  ['5w'],
                \ '<M-e>':  ['5e'],
                \ '<M-b>':  ['5b'],
                \ '<M-g>e': ['5ge'],
            \ },
            \'c': {
                \ '<M-f>':  ['<S-Right>'],
                \ '<M-b>':  ['<S-Left>'],
                \ 'ÿ':      ['<c-w>'],
                \ '':   ['<c-w>'],
            \ },
            \ }

" map alt key end



" find project root, use autotags F4 feature
fu! s:PathHash(val)
    retu substitute(system("sha1sum", a:val), " .*", "", "")
endf

fu! g:GetProjectRootHash()
    " find autotags subdir
    if !exists("g:autotagsdir")
        let g:autotagsdir = $HOME . "/.autotags/byhash"
    endif

    let l:dir = getcwd()
    wh l:dir != "/"
        if getftype(g:autotagsdir . '/' . s:PathHash(l:dir)) == "dir"
            let l:autotagsroot = g:autotagsdir . '/' . s:PathHash(l:dir)
            " echomsg "autotags root exist: " . l:autotagsroot
            break
        endif
        " get parent directory
        let l:dir = fnamemodify(l:dir, ":p:h:h")
    endw

    if !exists("l:autotagsroot") ||
                \ !isdirectory(l:autotagsroot) ||
                \ !isdirectory(l:autotagsroot . '/origin') ||
                \ !isdirectory(resolve(l:autotagsroot . '/origin'))
        " echomsg "Invalid Autotags' root directory!"
        retu
    en

    retu l:autotagsroot
endf

fu! g:GetProjectRoot(...)
    let l:hashRoot = a:0 ? a:1 : g:GetProjectRootHash()
    if empty(l:hashRoot)
        retu
    en

    retu resolve(l:hashRoot . "/origin")
endf

fu! s:exe_cmd_without_autocmd(cmd)
    let l:bak = &eventignore
    set eventignore=all
    exe a:cmd
    let &eventignore = l:bak
endf

" nerdtree configuration
" nerdtree win width setting
let g:NERDTreeWinSize = 31
let g:NERDTreeBufNamePrefix = "NERD_tree_"

" specify custom ignored dirs for autotags,ctrlp...
let g:custom_ignored_dirs = [
    \ ]

let g:autotags_cscope_ignored_dirs = ""
let g:autotags_ctags_exclude_opts = ""
let g:ctrlp_custom_ignored_dirs = []

" specify custom dirs for autotags,ctrlp...
let g:custom_specified_dirs = [
    \ 'kernel/include/uapi/linux',
    \ 'kernel/drivers/media/v4l2-core',
    \ 'system/core/include',
    \ 'hardware/libhardware/include',
    \ 'system/core/libutils',
    \ 'frameworks/av/camera',
    \ 'frameworks/av/services/camera',
    \ 'frameworks/av/include/camera',
    \ 'frameworks/base/core/java/android/hardware/camera2',
    \ 'system/media/camera',
    \ ]

fu! g:InitCustomAutoDirs()
    let l:root = g:GetProjectRoot()
    if !isdirectory(l:root)
        " echomsg "no root"
        retu "NA"
    en

    let l:dirsFile = l:root . "/auto_dirs"
    if !filereadable(l:dirsFile)
        " echomsg "no auto dirs"
        retu "NA"
    en

    let l:dirs = readfile(l:dirsFile)
    if empty(l:dirs)
        " echomsg "empty auto dirs"
        retu "NA"
    en

    let l:firstCsd = 1
    let l:firstCid = 1
    " let g:custom_specified_dirs = []
    " let g:custom_ignored_dirs = []

    let l:type = 0
    for i in l:dirs
        if i == "SPECIFIED:"
            let l:type = 1
            if l:firstCsd == 1
                let g:custom_specified_dirs = []
                let l:firstCsd = 0
            en
        elsei i == "IGNORED:"
            let l:type = 2
            if l:firstCid == 1
                let g:custom_ignored_dirs = []
                let l:firstCid = 0
            en
        el
            " remove the first '/'
            let i = substitute(i, '^\/', '', '')
            " remove the last '/'
            let i = substitute(i, '\/$', '', '')
            if l:type == 1
                call add(g:custom_specified_dirs, i)
            elsei l:type == 2
                call add(g:custom_ignored_dirs, i)
            en
        en
    endfor
    return "OK"
endf

fu! g:UpdateCustomSpecifiedDirs()
    if !exists('g:custom_specified_dirs')
        echomsg "no specified dirs"
        retu
    en

    let g:autotags_specified_dirs = g:custom_specified_dirs
    let g:ctrlp_include_dirs = g:custom_specified_dirs
endf

fu! g:UpdateCustomIgnoredDirs()
    if !exists('g:custom_ignored_dirs')
        echomsg "no ignored dirs"
        retu
    en

    let g:autotags_cscope_ignored_dirs = ""
    let g:autotags_ctags_exclude_opts = ""
    let g:ctrlp_custom_ignored_dirs = []

    for i in g:custom_ignored_dirs
        let g:autotags_ctags_exclude_opts = g:autotags_ctags_exclude_opts . ",*/" . i . "/*"
        let g:autotags_cscope_ignored_dirs = g:autotags_cscope_ignored_dirs . " " . i
        call add(g:ctrlp_custom_ignored_dirs, i)
    endfo

    let g:autotags_ctags_opts = "--exclude={" . g:autotags_ctags_exclude_opts . "}"
    let g:ctrlp_custom_ignore['dir'] = '\v[\/]('.join(g:ctrlp_custom_ignored_dirs, '|').')$'
endf

"-----------------------------------------------------------------------------
" Autotags Settings
"-----------------------------------------------------------------------------
let g:autotagsdir = $HOME . "/.autotags/byhash"
let g:autotags_no_global = 1

" --c++-kinds=+p  : Adds prototypes in the database for C/C++ files.
" --fields=+iaS   : Adds inheritance (i), access (a) and function signatures (S) information.
" --extra=+q      : Adds context to the tag name. Note: Without this option, the script cannot get class members.
let g:autotags_ctags_opts = "--exclude={" . g:autotags_ctags_exclude_opts . "}"

" Restrict files scanned for tags to those mapped to languages
" specified in the list. The list can contain any built-in or user-defined language [all]
let g:autotags_ctags_languages = "+Asm,+C,+C#,+C++,+Java,+JavaScript,+Vim,+Swift"
" let g:autotags_ctags_languages = "all"

" Donot override default mapping of language to input file extension
let g:autotags_ctags_langmap = ""
" let g:autotags_ctags_langmap = "Scala:.scala,Java:.java,Vim:.vim,JavaScript:.js,Swift:.swift"
let g:autotags_ctags_global_include = ""
let g:autotags_specified_dirs = g:custom_specified_dirs
let g:autotags_cscope_file_extensions = ".cpp .cc .cxx .hpp .hh .h .hxx .c .m .asm .s .java .js .py .idl .dts .dtsi .swift"

" define custom win height
let g:MyWinHeight=20
let &cmdwinheight=g:MyWinHeight
" execute "set cmdwinheight=".g:MyWinHeight

" qf win
if has("cscope") && has("quickfix")
    " if v:version >= 704
    if has("enhanced_edition")
        set cscopequickfix=c-!,d-!,e-!,f0,g-!,i0,s-!,t-!
    el
        set cscopequickfix=c-,d-,e-,g-,s-
    en
endif
let g:QuickfixWinHeight = g:MyWinHeight
nnoremap <silent> ,, :ToggleQuickfixWin<CR>

" help tag-matchlist, g]
nnoremap <silent> tn :tn<CR>
nnoremap <silent> tp :tp<CR>

" location list win
let g:locate_max_height = g:QuickfixWinHeight
let g:locate_focus = 1
let g:locate_colon_jump = 0
" let g:locate_jump_to = 'closest'

"hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
"autocmd BufRead,BufNewFile * syn match parens /[(){}]/ | hi parens ctermfg=darkyellow
let g:rainbow_active = 1

" nnoremap <silent> <Left> :bp<CR>
" nnoremap <silent> <Right> :bn<CR>
" nnoremap <Up> gT
" nnoremap <Down> gt

"p what you d/y, not v
" xnoremap <expr> p v:register=='"'?'pbvey':'gp"'
" xnoremap p pgvy
xnoremap p pgvy`]

" like D
nnoremap Y y$

"p what you y, not d
" nnoremap d "_d
" vnoremap d "_d

"align like si
" nnoremap <Tab> V>
" nnoremap <S-Tab> V<
" vmap <Tab> >gv
" vmap <S-Tab> <gv

" auto pair
" let g:AutoPairsFlyMode = 1

" MRU
nnoremap <silent> <Space>m :MRU<CR>
let g:MRU_Window_Height = g:MyWinHeight
let g:MRU_Exclude_Files = '/.git\|/.repo\|/.svn\|/.cache'

" remembering last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" leaderf
" let g:Lf_WindowHeight = g:MyWinHeight
" nnoremap <silent> <Space>l :Leaderf<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlp mode:         0 - IGNORE,    1 - INCLUDE
" ctrlp INCLUDE type: 0 - SPECIFIED, 1 - AUTOTAGS
" command: CtrlPToggleMode, CtrlPToggle2Autotags, CtrlPQueryToggleInfo

let g:ctrlp_map = '<Space>p'
nnoremap <silent> <Space><F7> :CtrlPTag<CR>
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 15000
let g:ctrlp_by_filename = 1
let g:ctrlp_working_path_mode = 0 " 'ra'
let g:ctrlp_max_height = g:MyWinHeight

" one way: only add the folders except ignored dir
" e.g. \ 'xxx\/xxx\/xxx',
" let g:ctrlp_custom_ignored_dirs = [
"     \ 'xxx\/xxx\/xxx',
"     \ ]
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]('.join(g:ctrlp_custom_ignored_dirs, '|').')$',
    \ 'file': '\v(\.cpp|\.cc|\.cxx|\.hpp|\.hh|\.h|\.hxx|\.c|\.m|\.asm|\.s|\.java|\.js|\.py|\.idl|\.dts|\.dtsi|\.swift)@<!$',
    \ }

" 0: ignore case, 1: match case
let g:ctrlp_ignore_case_type = 1

" \ 'file': '\v(\.cpp|\.h|\.hh|\.cxx)@<!$',
" set wildignore+=*/frameworks/rs*,*/external/*,*/bionic/*,*/art/*        " Linux/MacOSX

" another way: only add specified folders
let g:ctrlp_include_dirs = g:custom_specified_dirs

" key mapping
let g:ctrlp_prompt_mappings = {
            \ 'AcceptSelection("e")': ['<c-o>'],
            \ 'OpenMulti()':          ['<cr>'],
            \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" cSyntaxAfter setting
au! BufRead,BufNewFile,BufEnter *.{c,cpp,h,java,javascript,py} call CSyntaxAfter()

" powerline color setting
let g:Powerline_colorscheme = "solarized256"
let g:Powerline_theme = "solarized256"

" mark setting
nmap <unique> <silent> mm <Plug>MarkSet
vmap <unique> <silent> mm <Plug>MarkSet
nmap <unique> <silent> mr <Plug>MarkRegex
vmap <unique> <silent> mr <Plug>MarkRegex
nmap <unique> <silent> mn <Plug>MarkAllClear
nmap <unique> <silent> <Leader>* <Plug>MarkSearchAnyNext
nmap <unique> <silent> <Leader># <Plug>MarkSearchAnyPrev

" highlight and remove the trailing whitespace
highlight TrailingSpace ctermbg=red guibg=red
match TrailingSpace /\s\+$/
au TabEnter * match TrailingSpace /\s\+$/

fu! TrimTrailingSpace()
    %s/\s\+$//e
endf
com! TrimTrailingSpace call TrimTrailingSpace()

" qf or ll signs config. Caution of cs performance
let g:vim_addon_signs = { 'provide_qf_command' : 0,
                        \ 'provide_el_command' : 0,
                        \ 'process_max' : 1000}

" tagbar configuration
" e.g. non-sort, leader-space key, none syntax match of
" kind&scope
let g:tagbar_bufname_prefix = "__Tagbar__."
let g:tagbar_width = 40
let g:tagbar_sort = 0
let g:tagbar_map_jump = ['o', '<CR>']
let g:tagbar_map_preview = 'go'
let g:tagbar_map_showproto = '<Leader><Space>'
let g:tagbar_map_togglefold = 'za'
let g:tagbar_map_zoomwin = 'A'
let g:tagbar_nerdtree_filetype = 'nerdtree'
" DONOT set it to a very low value,  e.g. 500
let g:tagbar_update_time = 1000

" disable solarized toggle bg
let g:no_plugin_maps = 0


" add quick log

" func! QuickLog(...)
"   :normal OALOGD("%s: ", __func__);
"   :normal ==2f"i
" endf
" com! Lg call QuickLog()
nnoremap <silent> <Leader>lg OALOGD("%s: ", __func__);<C-[>==2f"i

" Fugitive configuration

" Change the default Gblame window ops from vsplit to edit, and donot set winfixwidth
let g:fugitive_blame_win_overlay = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" restore the appropriate window setting, e.g. vertical resize xx, echo winwidth(x)...

fu! SetWinWidth(winnr, width)
    if a:winnr < 0 || a:width < 1
        echoerr "Invalid input ! winnr = " . a:winnr . " width = " . a:width
        retu
    en

    let w = winwidth(a:winnr)
    if w != a:width
        let bak = winnr()
        if bak != a:winnr
            call s:exe_cmd_without_autocmd(a:winnr . 'wincmd w')
        en
        echo "Resize win" . a:winnr . " width to " . a:width . ". 'set winfixwidth<' if necessary"
        exe 'vert resize ' . a:width
        if bak != a:winnr
            call s:exe_cmd_without_autocmd('wincmd p')
        en
    en
endf

fu! RestoreWinLayout()
    let l:wincnt = winnr('$')
    " only fix the typical usecase of bad winwidth, reset to win1=nerdtree(31),win2=file(136),win3=tagbar(40)
    if l:wincnt != 3
        retu
    en

    let l:fixnerdtreewin = 1
    let l:fixfilewin = 2
    let l:fixtagbarwin = 3

    " go to the center win firstly
    call s:exe_cmd_without_autocmd(l:fixfilewin . 'wincmd w')
    if &winfixwidth == 1
        set winfixwidth<
    en

    for winnr in range(1, wincnt)
        let bufnr = winbufnr(winnr)
        if bufnr != -1
            let l:bufname = bufname(bufnr)
            if l:bufname =~ g:NERDTreeBufNamePrefix
                if winnr == l:fixnerdtreewin
                    call SetWinWidth(winnr, g:NERDTreeWinSize)
                en
            elsei l:bufname =~ g:tagbar_bufname_prefix
                if winnr == l:fixtagbarwin
                    call SetWinWidth(winnr, g:tagbar_width)
                en
            el
                " do nothing
            en
        en
    endfo
endf

com! RestoreWinLayout call RestoreWinLayout()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" disable \\ commentary
let g:commentary_map_backslash = 0

" .h files can be C, Ch C++, ObjC or ObjC++.
" Set c_syntax_for_h if you want C, ch_syntax_for_h if you want Ch. ObjC is detected automatically.
" e.g. 1 means .h is c-type, otherwise is cpp-type
" let g:c_syntax_for_h = 1

" gundo settings
let g:gundo_right = 1
let g:gundo_preview_height = g:MyWinHeight
let g:gundo_preview_bottom = 1

" enhance cscope caseless -C option
" update -C option to caseinsensitive -C [a or cdefgist], a: all searches are caseinsensitive
if g:cscope_enhanced_edition == 1
    let g:cs_casesensitive_opt = "\\ -Cef"
    exec "set csprg+=" . g:cs_casesensitive_opt
    " set csprg+=\ -Cef
    " or
    " let &csprg = "cscope -Cef"
en

fu! CscopeCaseSensitiveReset()
    if !exists('g:cs_casesensitive_opt')
        retu
    en

    exec "set csprg-=" . g:cs_casesensitive_opt
    " set csprg-=\ -Cef
    silent cs reset
    echomsg "cscope casesensitive has been reset"
endf
com! CscopeCaseSensitiveReset call CscopeCaseSensitiveReset()


" initial calls
if g:InitCustomAutoDirs() == "OK"
    call g:UpdateCustomIgnoredDirs()
en

"happy added end
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

