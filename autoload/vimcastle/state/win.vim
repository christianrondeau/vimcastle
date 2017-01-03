function! vimcastle#state#win#enter(state) abort
endfunction

function! vimcastle#state#win#action(state, key) abort
	unlet a:state.enemy
	call a:state.enter('explore')
	return 1
endfunction
