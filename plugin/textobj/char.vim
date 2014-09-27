" Vim global plugin to define text-object for selecting a character
" Last Change: 26-Sep-2014.
" Maintainer : Masaaki Nakamura <mckn@outlook.com>

" License    : NYSL
"              Japanese <http://www.kmonos.net/nysl/>
"              English (Unofficial) <http://www.kmonos.net/nysl/index.en.html>

if exists("g:loaded_textobj_char")
  finish
endif
let g:loaded_textobj_char = 1

onoremap <silent><expr> <Plug>(textobj-char-f-i) textobj#char#i_f('o')
xnoremap <silent><expr> <Plug>(textobj-char-f-i) textobj#char#i_f('x')

onoremap <silent><expr> <Plug>(textobj-char-F-i) textobj#char#i_F('o')
xnoremap <silent><expr> <Plug>(textobj-char-F-i) textobj#char#i_F('x')

onoremap <silent><expr> <Plug>(textobj-char-f-a) textobj#char#a_f('o')
xnoremap <silent><expr> <Plug>(textobj-char-f-a) textobj#char#a_f('x')

onoremap <silent><expr> <Plug>(textobj-char-F-a) textobj#char#a_F('o')
xnoremap <silent><expr> <Plug>(textobj-char-F-a) textobj#char#a_F('x')
