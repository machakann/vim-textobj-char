" Vim global plugin to define text-objects for selecting a character
" Last Change: 27-Aug-2018.
" Maintainer : Masaaki Nakamura <mckn{at}outlook.com>

" License    : NYSL
"              Japanese <http://www.kmonos.net/nysl/>
"              English (Unofficial) <http://www.kmonos.net/nysl/index.en.html>

if exists("g:loaded_textobj_char")
  finish
endif
let g:loaded_textobj_char = 1

onoremap <silent><expr> <Plug>(textobj-char-i-f) textobj#char#keymap('i', 'forward', 'o')
xnoremap <silent><expr> <Plug>(textobj-char-i-f) textobj#char#keymap('i', 'forward', 'x')

onoremap <silent><expr> <Plug>(textobj-char-i-F) textobj#char#keymap('i', 'backward', 'o')
xnoremap <silent><expr> <Plug>(textobj-char-i-F) textobj#char#keymap('i', 'backward', 'x')

onoremap <silent><expr> <Plug>(textobj-char-a-f) textobj#char#keymap('a', 'forward', 'o')
xnoremap <silent><expr> <Plug>(textobj-char-a-f) textobj#char#keymap('a', 'forward', 'x')

onoremap <silent><expr> <Plug>(textobj-char-a-F) textobj#char#keymap('a', 'backward', 'o')
xnoremap <silent><expr> <Plug>(textobj-char-a-F) textobj#char#keymap('a', 'backward', 'x')
