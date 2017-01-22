function! vimcastle#state#explore#enter(state) abort
	call a:state.nav.add('i', 'Inventory', function('s:nav_inventory'))
	call a:state.nav.add('s', 'Character Sheet', function('s:nav_character'))
endfunction

function! s:nav_inventory(state) abort
	call a:state.enter('inventory')
	return 1
endfunction

function! s:nav_character(state) abort
	call a:state.enter('character')
	return 1
endfunction
