function! vimcastle#state#intro#enter(state) abort
	let a:state.actions = {
		\'any': {
		\  'name': 'Start',
		\  'fn': function('s:action_newgame')
		\}
		\}
endfunction

function! s:action_newgame(state) abort
	call a:state.newgame()
	call a:state.enter('explore')
	return 1
endfunction
