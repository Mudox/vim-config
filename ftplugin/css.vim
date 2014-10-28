" vim: foldmethod=marker

" tab   {{{1
setlocal foldmethod=marker
setlocal tabstop=8
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smarttab
setlocal expandtab
" }}}1

setlocal foldmethod=syntax
setlocal foldenable

setlocal foldtext=CSSFoldText()
function! CSSFoldText()
  let l:firstline = getline(v:foldstart)
  let l:sub = substitute(l:firstline, '{.*$', '', 'g')
  let l:prefix = '» '
  let l:foldline = l:prefix . l:sub
  return l:foldline
endfunction

nnoremap <buffer> \ff <Esc><Esc>:call CssAlignGlobal()<Cr>
function! CssAlignGlobal() " {{{2
  %s/{\(\s*\%(\/\*.*\*\/\)\?\s*$\)\@!/{\r/e
  %s/\(^\s*\)\@<!}/\r}/e
  AlignCtrl mwrl:g :[^:]*;\%(\)\s*$
  %Align :
endfunction "  }}}2
