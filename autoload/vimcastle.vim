let s:state = {}

function! vimcastle#initplayer() abort
	let s:state.player = {
      \ 'name': {
        \ 'long': 'Player',
        \ 'short': 'You'
        \ },
      \ 'health': {
        \ 'current': 100,
        \ 'max': 100,
        \ }
      \ }
	let s:state.enemy = {
      \ 'name': {
        \ 'long': 'Enemy',
        \ 'short': 'Enemy'
        \ },
      \ 'health': {
        \ 'current': 100,
        \ 'max': 100,
        \ }
      \ }
endfunction

function! vimcastle#initmappings() abort
	nnoremap <buffer> 1 :call vimcastle#hit()<cr>
endfunction

function! vimcastle#hit() abort
	let s:state.enemy.health.current -= 1
	call vimcastle#ui#draw(s:state)
endfunction

function! vimcastle#start() abort
	call vimcastle#ui#init()
	call vimcastle#initplayer()
	call vimcastle#initmappings()
	call vimcastle#ui#draw(s:state)
endfunction
