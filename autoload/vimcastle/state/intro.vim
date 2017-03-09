function! vimcastle#state#intro#enter(state) abort
 	call a:state.actions().clear()
	call a:state.actions().addDefault()
endfunction

function! vimcastle#state#intro#action(name, state) abort
	call a:state.enter('menu')
endfunction
