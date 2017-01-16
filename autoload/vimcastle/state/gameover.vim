function! vimcastle#state#gameover#enter(state) abort
	let a:state.actions.enabled = 0
	call a:state.nav.addDefault('Restart', function('s:nav_restart'))
endfunction

function! s:nav_restart(state) abort
	call a:state.reset()
	call a:state.enter('intro')
endfunction
