function! vimcastle#states#inventory#create() abort
	let instance = {}
	let instance.cansave = 1
	let instance.enter = function('s:enter')
	let instance.action_use = function('s:action_use')
	let instance.action_character = function('s:action_character')
	let instance.action_back = function('s:action_back')
	return instance
endfunction

function! s:enter(game) abort dict
	if(exists('a:game.player.items') && len(a:game.player.items))
		call a:game.actions.add('use', 'u', 'Use an item')
	endif

	call a:game.actions
				\.add('character', 's', 'Character Sheet')
				\.add('back', 'b', 'Back')
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
