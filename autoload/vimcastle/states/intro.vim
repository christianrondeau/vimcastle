function! vimcastle#states#intro#create() abort
	let instance = {}
	let instance.enter = function('s:enter')
	let instance.action = function('s:action')
	return instance
endfunction

function! s:enter(game) abort dict
	return vimcastle#bindings#default()
endfunction

function! s:action(name, game) abort dict
	return a:game.enter('menu')
endfunction
