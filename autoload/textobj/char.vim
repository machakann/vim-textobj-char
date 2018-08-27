let s:save_cpo = &cpo
set cpo&vim

let s:FALSE = 0
let s:TRUE = 1
let s:NULLPOS = [0, 0]

let s:dotrepeat = s:TRUE

function! textobj#char#if(mode) abort
  return s:getchar('if', a:mode)
endfunction

function! textobj#char#iF(mode) abort
  return s:getchar('iF', a:mode)
endfunction

function! textobj#char#af(mode) abort
  return s:getchar('af', a:mode)
endfunction

function! textobj#char#aF(mode) abort
  return s:getchar('aF', a:mode)
endfunction



function! s:getchar(kind, mode) abort
  " target character assginment
  while 1
    let c = getchar()
    if c !=# "\<CursorHold>" | break | endif
  endwhile
  let c = type(c) == type(0) ? nr2char(c) : c

  if c ==# "\<Esc>" || c ==# "\<C-c>"
    let cmd = (a:mode ==# 'o') ? "\<Esc>" : 'gv'
  else
    let cmd = printf(":\<C-u>call textobj#char#search('%s','%s','%s',%d)\<CR>",
                   \ a:kind, a:mode, c, v:count1)

  endif

  let s:dotrepeat = s:FALSE
  return cmd
endfunction

function! textobj#char#search(kind, mode, c, count) abort
  let view = winsaveview()
  let lnum = view.lnum
  let flag = a:kind[1] ==# 'F' ? 'b' : ''
  let n = s:dotrepeat is# s:FALSE ? a:count : v:count1
  let c = escape(a:c, '~"\.^$[]*')
  for i in range(n)
    let pos = searchpos(c, flag, lnum)
  endfor

  if pos != s:NULLPOS
    let [head, tail] = [pos, pos]
    if a:kind[0] ==# 'a'
      let head = searchpos('\%(^\|\S\)\zs\s*\%#', 'bcn', lnum)
      let tail = searchpos('\%#.\s*\ze\%(\S\|$\)', 'cen', lnum)
    endif
    call s:select(head, tail)
  else
    call winrestview(view)
    if a:mode ==# 'x'
      normal! gv
    endif
  endif
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

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2:
