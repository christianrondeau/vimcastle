function! vimcastle#state#win#enter(state) abort
endfunction

function! vimcastle#state#win#action(state, key) abort
	call vimcastle#state#enter('explore')
	return 1
endfunction
