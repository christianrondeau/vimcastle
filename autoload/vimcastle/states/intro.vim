function! vimcastle#states#intro#create() abort
	let instance = {}
	let instance.cansave = 0
	let instance.enter = function('s:enter')
	let instance.action_default = function('s:action_default')
	return instance
endfunction

function! s:enter(game) abort dict
	if(exists('g:vimcastle_skipintro') && g:vimcastle_skipintro == 1)
		return a:game.enter('menu')
	else
		call a:game.actions.addDefault()
	endif
endfunction

function! s:action_default(game) abort dict
	return a:game.enter('menu')
endfunction
