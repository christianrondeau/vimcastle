function! vimcastle#state#gameover#enter(state) abort
	call a:state.clearlog()
 	call a:state.actions().clear()
	call a:state.actions().addDefault('Restart', function('s:action_restart'))
endfunction

function! s:action_restart(state) abort
	call a:state.reset()
	call a:state.enter('intro')
endfunction
