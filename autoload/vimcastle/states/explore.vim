function! vimcastle#states#explore#create() abort
	let instance = {}
	let instance.enter = function('s:enter')
	let instance.action = function('s:action')
	return instance
endfunction

function! s:enter(game) abort dict
	return a:game.event.enter(a:game)
endfunction

function! s:action(name, game) abort
	return a:game.event.action(a:name, a:game)
endfunction

