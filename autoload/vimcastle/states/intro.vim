function! vimcastle#states#intro#create() abort
	let instance = {}
	let instance.enter = function('s:enter')
	let instance.action = function('s:action')
	return instance
endfunction

function! s:enter(game) abort dict
	call a:game.actions.addDefault()
endfunction

function! s:action(name, game) abort dict
	return a:game.enter('menu')
endfunction
