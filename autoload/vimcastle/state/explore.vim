function! vimcastle#state#explore#enter(state) abort
endfunction

function! vimcastle#state#explore#action(name, state) abort
	call a:state.event.action(a:name, a:state)
endfunction
