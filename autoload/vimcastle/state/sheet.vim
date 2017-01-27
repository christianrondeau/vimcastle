function! vimcastle#state#sheet#enter(state) abort
	call a:state.nav.add('i', 'Inventory', function('s:nav_inventory'))
	call a:state.nav.add('b', 'Back', function('s:nav_back'))
endfunction

function! s:nav_inventory(state) abort
	call a:state.enter('inventory')
	return 1
endfunction

function! s:nav_back(state) abort
	call a:state.enter('explore')
	return 1
endfunction
