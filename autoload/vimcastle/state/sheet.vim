function! vimcastle#state#sheet#enter(state) abort
 	call a:state.actions().clear()
	call a:state.actions().add('i', 'Inventory', function('s:action_inventory'))
	call a:state.actions().add('b', 'Back', function('s:action_back'))
endfunction

function! s:action_inventory(state) abort
	call a:state.enter('inventory')
	return 1
endfunction

function! s:action_back(state) abort
	call a:state.enter('explore')
	return 1
endfunction
