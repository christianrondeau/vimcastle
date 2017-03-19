function! vimcastle#states#intro#create() abort
	let instance = {}
	let instance.cansave = 0
	let instance.enter = function('s:enter')
	let instance.action_default = function('s:action_default')
	return instance
endfunction

function! s:enter(game) abort dict
	call a:game.actions.addDefault()
endfunction

function! s:action_default(game) abort dict
	return a:game.enter('menu')
endfunction
