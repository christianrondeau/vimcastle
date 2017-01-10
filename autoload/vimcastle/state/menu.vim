function! vimcastle#state#menu#enter(state) abort
	call a:state.actions.add('n', 'New Game', function('s:action_newgame'))
	call a:state.actions.add('h', 'Help', function('s:action_help'))
	call a:state.actions.add('q', 'Quit', function('s:action_help'))

	let a:state.log = ['Adventure!']
endfunction

function! s:action_newgame(state) abort
	call a:state.reset()
	call vimcastle#stories#main#index#begin(a:state)
	call a:state.enter('explore')
	call a:state.scene.enter(a:state)
endfunction

function! s:action_help(state) abort
	help Vimcastle
endfunction
