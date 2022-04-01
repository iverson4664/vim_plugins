" happy's alt/meta key map, to speed up the cursor's movement in normal/insert/command... mode

if exists('loaded_altkeymap')
    finish
endif

let loaded_altkeymap = 1

" only support xterm currently
if &term !~ "xterm"
    finish
endif

if !exists('g:altDedicatedKeyMap')
    let g:altDedicatedKeyMap = { }
endif

" for i in range(65,90) + range(97,122)
" ignore key(65,90)-A,Z, e.g.77-'M'
let s:altDedicatedKeys = range(97, 122)
" e.g. BS:8-'control-H', 127-'control-?(127)'
let s:altDedicatedKeys += [8] + [127]
for i in s:altDedicatedKeys
    let c = nr2char(i)
    " exec "map \e".c." <S-M-".c.">"
    " exec "map! \e".c." <S-M-".c.">"
    " or set it like this
    exec "set <M-".c.">=\<Esc>".c
endfor

" let s:keys = map(range(97, 122), "nr2char(v:val)") " a-z
" let s:keys += map(range(48, 57), "nr2char(v:val)")  " 0-9
" let s:key_codes = map(range(1,37), '"<S-F".v:val.">"')
" set timeout timeoutlen=1000 ttimeoutlen=32
" for idx in range(len(s:keys))
"     let pc = s:keys[idx]
"     let kc  = s:key_codes[idx]
"     exec "set ".kc."=\e".pc
"     exec "map ".kc." <M-".pc.">"
"     exec "map! ".kc." <M-".pc.">"
" endfor

" make esc do nothing
" inoremap <Esc> <Nop>

for [adkmMode, adkmMap] in items(g:altDedicatedKeyMap)
    for [adkmKey, adkmTKey] in items(adkmMap)
        for iAdkmTKey in adkmTKey
            " echomsg adkmMode . " " . adkmKey . " " . iAdkmTKey
            exec adkmMode . "noremap " . adkmKey . " " . iAdkmTKey
        endfor
    endfor
endfor

" nnoremap <M-h> 5h
" nnoremap <M-j> 5j
" nnoremap <M-k> 5k
" nnoremap <M-l> 5l
" nnoremap <M-w> 5w
" nnoremap <M-e> 5e
" nnoremap <M-b> 5b
" nnoremap <M-g>e 5ge

" vnoremap <M-h> 5h
" vnoremap <M-j> 5j
" vnoremap <M-k> 5k
" vnoremap <M-l> 5l
" vnoremap <M-w> 5w
" vnoremap <M-e> 5e
" vnoremap <M-b> 5b
" vnoremap <M-g>e 5ge

" see command-line built-in hotkey for movement and editing by :h cmdline-editing or ex-edit-index
" cursor one WORD left/right
" cnoremap <M-f> <S-Right>
" cnoremap <M-b> <S-Left>

" cnoremap <M-BS> <c-w> can't work, so add an alternative for <M-BS>
" if &term == "xterm"
" ÿ - y-umlaut, when backspace key is set to 'control-?(127) / '
" cnoremap ÿ <c-w>
"  - � ,(unicode)U+0088, utf8-c2 88, when backspace key is set to 'control-H(8) / '
" cnoremap  <c-w>
" endif

