function! vimcastle#state#intro#enter(state) abort
endfunction

function! vimcastle#state#intro#action(state, key) abort
	call a:state.newgame()
	call a:state.enter('explore')
	return 1
endfunction
