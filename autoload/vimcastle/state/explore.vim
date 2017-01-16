function! vimcastle#state#explore#enter(state) abort
	let a:state.actions.enabled = 1
	call a:state.nav.add('i', 'Inventory', function('s:nav_inventory'))
endfunction

function! s:nav_inventory(state) abort
	call a:state.enter('inventory')
	return 1
endfunction
