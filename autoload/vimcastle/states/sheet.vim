function! vimcastle#states#sheet#create() abort
	let instance = {}
	let instance.cansave = 1
	let instance.enter = function('s:enter')
	let instance.action_inventory = function('s:action_inventory')
	let instance.action_back = function('s:action_back')
	return instance
endfunction

function! s:enter(game) abort dict
 	call a:game.actions
				\.add('inventory', 'i', 'Inventory')
				\.add('back', 'b', 'Back')
endfunction

function! s:action_inventory(game) abort
	return a:game.enter('inventory')
endfunction

function! s:action_back(game) abort
	return a:game.enter('explore')
endfunction
