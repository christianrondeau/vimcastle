function! vimcastle#state#explore#enter(state) abort
	let a:state.enemy = vimcastle#character#random()
endfunction

function! vimcastle#state#explore#action(state, key) abort
	call a:state.enter('fight')
	return 1
endfunction
