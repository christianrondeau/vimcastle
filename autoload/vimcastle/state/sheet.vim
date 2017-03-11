function! vimcastle#state#sheet#enter(state) abort
 	call a:state.actions().clear()
	call a:state.actions().add('inventory', 'i', 'Inventory')
	call a:state.actions().add('back', 'b', 'Back')
endfunction

function! vimcastle#state#sheet#action(name, state) abort
	execute 'call s:action_' . a:name . '(a:state)'
endfunction

function! s:action_inventory(state) abort
	call a:state.enter('inventory')
	return 1
endfunction

function! s:action_back(state) abort
	call a:state.enter('explore')
	return 1
endfunction
