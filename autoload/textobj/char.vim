let s:save_cpo = &cpo
set cpo&vim

let s:plug_cap = "\<Plug>"
let s:cursorhold = s:plug_cap[0:1] . '`'
unlet s:plug_cap

let s:state    = 0
let s:null_pos = [0, 0]



function! textobj#char#i_f(mode)
  return s:clerk('if', a:mode)
endfunction

function! textobj#char#i_F(mode)
  return s:clerk('iF', a:mode)
endfunction

function! textobj#char#a_f(mode)
  return s:clerk('af', a:mode)
endfunction

function! textobj#char#a_F(mode)
  return s:clerk('aF', a:mode)
endfunction



function! s:clerk(kind, mode)
  " target character assginment
  while 1
    let c = getchar()
    if c != s:cursorhold | break | endif
  endwhile
  let c = type(c) == type(0) ? nr2char(c) : c

  if c ==# "\<Esc>" || c ==# "\<C-c>"
    let cmd = (a:mode == 'o') ? "\<Esc>" : "gv"
  else
    let cmd = printf(":\<C-u>call textobj#char#searcher('%s','%s','%s',%s)\<CR>",
          \           a:kind, a:mode, c, v:count1)

  endif

  let s:state = 1
  return cmd
endfunction

function! textobj#char#searcher(kind, mode, c, count)
  let view = winsaveview()
  let lnum = view.lnum
  let flag = a:kind[1] ==# 'F' ? 'b' : ''
  let c    = escape(a:c, '~"\.^$[]*')
  for i in range(s:state ? a:count : v:count1)
    let pos  = searchpos(c, flag, lnum)
  endfor

  if pos != s:null_pos
    if a:kind[0] ==# 'i'
      let [head, tail] = [pos, pos]
    else
      let head = searchpos( '\%(^\|\S\)\zs\s*\%#', 'bcn', lnum)
      let tail = searchpos('\%#.\s*\ze\%(\S\|$\)', 'cen', lnum)
    endif
  else
    call winrestview(view)
    let [head, tail] = [copy(s:null_pos), copy(s:null_pos)]
  endif

  call s:selector(a:mode, head, tail)
  let s:state = 0
  return
endfunction

function! s:selector(mode, head, tail)
  if a:head != s:null_pos && a:tail != s:null_pos
    let visualmode = a:mode ==# 'o' || visualmode() ==? 'v' ? 'v' : "\<C-v>"

    execute 'normal! ' . visualmode
    call cursor(a:head)
    normal! o
    call cursor(a:tail)

    " counter measure for the 'selection' option being 'exclusive'
    if &selection == 'exclusive'
      normal! l
    endif
  else
    if a:mode ==# 'x'
      normal! gv
    endif
  endif
  return
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2:
