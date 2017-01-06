function! vimcastle#state#win#enter(state) abort
	call a:state.actions.add('c', 'Continue', function('s:action_continue'))
endfunction

function! s:action_continue(state) abort
	unlet a:state.enemy
	call a:state.enter('explore')
	return 1
endfunction
