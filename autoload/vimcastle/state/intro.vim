function! vimcastle#state#intro#enter(state) abort
endfunction

function! vimcastle#state#intro#action(state, key) abort
	call vimcastle#state#enter('fight')
	return 1
endfunction
