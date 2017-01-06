function! vimcastle#state#menu#enter(state) abort
	call a:state.actions.add('n', 'New Game', function('s:action_newgame'))
	call a:state.actions.add('h', 'Help', function('s:action_help'))
	call a:state.actions.add('q', 'Quit', function('s:action_help'))
endfunction

function! s:action_newgame(state) abort
	call a:state.newgame()
	return 1
endfunction

function! s:action_help(state) abort
	help Vimcastle
endfunction
