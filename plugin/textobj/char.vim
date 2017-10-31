" Vim global plugin to define text-object for selecting a character
" Last Change: 31-Oct-2017.
" Maintainer : Masaaki Nakamura <mckn{at}outlook.com>

" License    : NYSL
"              Japanese <http://www.kmonos.net/nysl/>
"              English (Unofficial) <http://www.kmonos.net/nysl/index.en.html>

if exists("g:loaded_textobj_char")
  finish
endif
let g:loaded_textobj_char = 1

onoremap <silent><expr> <Plug>(textobj-char-f-i) textobj#char#if('o')
xnoremap <silent><expr> <Plug>(textobj-char-f-i) textobj#char#if('x')

onoremap <silent><expr> <Plug>(textobj-char-F-i) textobj#char#iF('o')
xnoremap <silent><expr> <Plug>(textobj-char-F-i) textobj#char#iF('x')

onoremap <silent><expr> <Plug>(textobj-char-f-a) textobj#char#af('o')
xnoremap <silent><expr> <Plug>(textobj-char-f-a) textobj#char#af('x')

onoremap <silent><expr> <Plug>(textobj-char-F-a) textobj#char#aF('o')
xnoremap <silent><expr> <Plug>(textobj-char-F-a) textobj#char#aF('x')
