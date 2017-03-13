function! vimcastle#states#inventory#create() abort
	let instance = {}
	let instance.enter = function('s:enter')
	let instance.action = function('s:action')
	return instance
endfunction

function! s:enter(game) abort dict
	let actions = vimcastle#bindings#create()

	if(exists('a:game.player.items') && len(a:game.player.items))
		call actions.add('use', 'u', 'Use an item')
	endif

	call actions.add('character', 's', 'Character Sheet')
	call actions.add('back', 'b', 'Back')
	return actions
endfunction

function! s:action(name, game) abort dict
	execute 'return s:action_' . a:name . '(a:game)'
endfunction

function! s:action_use(game) abort
	return a:game.enter('use')
endfunction

function! s:action_character(game) abort
	return a:game.enter('sheet')
endfunction

function! s:action_back(game) abort
	return a:game.enter('explore')
endfunction
