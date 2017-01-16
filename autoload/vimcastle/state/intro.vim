function! vimcastle#state#intro#enter(state) abort
	call a:state.nav.addDefault('Start', function('s:nav_start'))
endfunction

function! s:nav_start(state) abort
	call a:state.enter('menu')
	return 1
endfunction
