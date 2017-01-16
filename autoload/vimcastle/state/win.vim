function! vimcastle#state#win#enter(state) abort
	let a:state.actions.enabled = 0
	call a:state.nav.add('c', 'Continue', function('s:nav_continue'))
endfunction

function! s:nav_continue(state) abort
	unlet a:state.enemy
	call a:state.enter('explore')
	call a:state.nextaction(a:state)
	unlet a:state.nextaction
	return 1
endfunction
