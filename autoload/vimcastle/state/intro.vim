function! vimcastle#state#intro#enter(state) abort
	call a:state.actions.addDefault('Start', function('s:action_start'))
endfunction

function! s:action_start(state) abort
	call a:state.enter('menu')
	return 1
endfunction
