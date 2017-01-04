function! vimcastle#state#lose#enter(state) abort
endfunction

function! vimcastle#state#lose#action(state, key) abort
	call a:state.reset()
	return 1
endfunction
