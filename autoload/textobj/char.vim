let s:save_cpo = &cpo
set cpo&vim

let s:FALSE = 0
let s:TRUE = 1

let s:dotrepeat = s:TRUE


function! textobj#char#keymap(kind, direction, mode) abort
  " target character assginment
  while 1
    let c = getchar()
    if c !=# "\<CursorHold>" | break | endif
  endwhile
  let c = type(c) == type(0) ? nr2char(c) : c

  if c ==# "\<Esc>"
    " cancel the action
    return a:mode ==# 'x' ? 'gv' : "\<Esc>"
  endif

  let s:dotrepeat = s:FALSE
  return printf(":\<C-u>call textobj#char#search('%s',%d,'%s','%s','%s')\<CR>",
              \ c, v:count1, a:kind, a:direction, a:mode)
endfunction

function! textobj#char#search(c, count, kind, direction, mode) abort
  let view = winsaveview()

  let n = s:dotrepeat is# s:FALSE ? a:count : v:count1
  let c = escape(a:c, '~"\.^$[]*')
  let flag = a:direction ==# 'backward' ? 'b' : ''
  let lnum = line('.')
  for i in range(n)
    if searchpos(c, flag, lnum) == [0, 0]
      " `count`th `c` have not been found
      call s:restore(a:mode, view)
      return
    endif
  endfor

  if a:kind ==# 'a'
    let head = searchpos('\%(^\|\S\)\zs\s*\%#', 'bcn', lnum)
    let tail = searchpos('\%#.\s*\ze\%(\S\|$\)', 'cen', lnum)
  else
    let head = getpos('.')[1:2]
    let tail = head
  endif
  call s:select(head, tail)
  let s:dotrepeat = s:TRUE
endfunction

function! s:select(head, tail) abort
  normal! v
  call cursor(a:head)
  normal! o
  call cursor(a:tail)

  if &selection ==# 'exclusive'
    normal! l
  endif
endfunction

function! s:restore(mode, view) abort
  call winrestview(a:view)
  if a:mode ==# 'x'
    normal! gv
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2:
