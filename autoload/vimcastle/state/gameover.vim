function! vimcastle#state#gameover#enter(state) abort
	call a:state.actions.addDefault('Restart', function('s:action_restart'))
endfunction

function! s:action_restart(state) abort
	call a:state.reset()
endfunction