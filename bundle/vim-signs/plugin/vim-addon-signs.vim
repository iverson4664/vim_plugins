" exec vam#DefineAndBind('s:c','g:vim_addon_signs','{}')
if !exists('g:vim_addon_signs') | let g:vim_addon_signs = {} | endif | let s:c = g:vim_addon_signs

if get(s:c, 'provide_qf_command', 0)
  if has('signs')
    " sign define qf_error text=! linehl=ErrorMsg
    sign define qf_error text=! texthl=Normal linehl=Normal
  endif
  command! -nargs=0 -bar QuickfixSignsUpdate call vim_addon_signs#Push("my_quick_fix_errors", vim_addon_signs#SignsFromLocationList(getqflist(), "qf_error"))
  command! -nargs=0 -bar QuickfixSignsClear call vim_addon_signs#Push("my_quick_fix_errors", [])

  augroup VIM_ADDON_SIGNS
    au!
    autocmd QuickFixCmdPost * QuickfixSignsUpdate
  augroup end

endif

if get(s:c, 'provide_el_command', 0)
  if has('signs')
    sign define qf_error text=! texthl=Normal linehl=Normal
  endif
  command! -nargs=0 -bar LocationlistSignsUpdate call vim_addon_signs#Push("my_quick_fix_errors", vim_addon_signs#SignsFromLocationList(getloclist(), "qf_error"))
  command! -nargs=0 -bar LocationlistSignsClear call vim_addon_signs#Push("my_quick_fix_errors", [])
endif
