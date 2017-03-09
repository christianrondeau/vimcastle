function! vimcastle#state#intro#enter(state) abort
 	call a:state.actions().clear()
	call a:state.actions().addDefault('Start')
endfunction

function! vimcastle#state#intro#action(key, state) abort
	call a:state.enter('menu')
	return 1
endfunction
