function! vimcastle#states#explore#create() abort
	let instance = {}
	let instance.cansave = 1
	let instance.enter = function('s:enter')
	let instance.action = function('s:action')
	return instance
endfunction

function! s:enter(game) abort dict
	if(!exists('a:game.event'))
		throw 'An event is required'
	endif
	return a:game.event.enter(a:game)
endfunction

function! s:action(name, game) abort
	call a:game.event.action(a:name, a:game)
endfunction

