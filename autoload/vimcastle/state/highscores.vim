function! vimcastle#state#highscores#enter(state) abort
	call a:state.clearlog()
 	call a:state.actions().clear()
	call a:state.actions().add('b', 'Menu', function('s:action_menu'))
endfunction

function! s:action_menu(state) abort
	call a:state.enter('menu')
endfunction
