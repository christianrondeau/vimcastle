function! vimcastle#states#sheet#create() abort
	let instance = {}
	let instance.enter = function('s:enter')
	let instance.action = function('s:action')
	return instance
endfunction

function! s:enter(game) abort dict
 	call a:game.actions
				\.add('inventory', 'i', 'Inventory')
				\.add('back', 'b', 'Back')
endfunction

function! s:action(name, game) abort
	execute 'return s:action_' . a:name . '(a:game)'
endfunction

function! s:action_inventory(game) abort
	return a:game.enter('inventory')
endfunction

function! s:action_back(game) abort
	return a:game.enter('explore')
endfunction
