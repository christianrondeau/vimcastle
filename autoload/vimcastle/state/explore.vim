function! vimcastle#state#explore#enter(state) abort
	call a:state.actions().add('i', 'Inventory', function('s:action_inventory'))
	call a:state.actions().add('s', 'Character Sheet', function('s:action_character'))
endfunction

function! s:action_inventory(state) abort
	call a:state.enter('inventory')
	return 1
endfunction

function! s:action_character(state) abort
	call a:state.enter('sheet')
	return 1
endfunction
