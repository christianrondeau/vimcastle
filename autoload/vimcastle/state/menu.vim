function! vimcastle#state#menu#enter(state) abort
	call a:state.actions.add('n', 'New Game', function('s:action_newgame'))
	call a:state.actions.add('h', 'Help', function('s:action_help'))
	call a:state.actions.add('q', 'Quit', function('s:action_help'))

	let a:state.log = ['Adventure!']
endfunction

function! s:action_newgame(state) abort
	call a:state.reset()
	let a:state.player = vimcastle#character#create('Player', 'You', 60)
	call a:state.enter('explore')
endfunction

function! s:action_help(state) abort
	help Vimcastle
endfunction
