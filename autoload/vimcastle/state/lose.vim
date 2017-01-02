function! vimcastle#state#lose#enter(state) abort
endfunction

function! vimcastle#state#lose#action(state, key) abort
	call vimcastle#state#enter('intro')
	return 1
endfunction
