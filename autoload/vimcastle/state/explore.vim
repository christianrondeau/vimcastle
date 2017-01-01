function! vimcastle#state#explore#enter(state) abort
endfunction

function! vimcastle#state#explore#action(state, key) abort
	call vimcastle#state#enter('fight')
	return 1
endfunction
