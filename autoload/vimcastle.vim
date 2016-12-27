let s:state = {}

function! vimcastle#initplayer() abort
	let s:state.player = {
				\ 'health': 100
				\ }
	let s:state.enemy = {
				\ 'health': 100
				\ }
endfunction

function! vimcastle#initmappings() abort
	nnoremap <buffer> 1 :call vimcastle#hit()<cr>
endfunction

function! vimcastle#hit() abort
	let s:state.enemy.health = s:state.enemy.health - 1
	call vimcastle#interface#draw(s:state)
endfunction

function! vimcastle#start() abort
	call vimcastle#interface#init()
	call vimcastle#initplayer()
	call vimcastle#initmappings()
	call vimcastle#interface#draw(s:state)
endfunction
