function! vimcastle#state#gameover#enter(state) abort
	let a:state.actions = {
		\'any': {
		\  'name': 'Restart',
		\  'fn': function('s:action_restart')
		\}
		\}
endfunction

function! s:action_restart(state) abort
	call a:state.reset()
endfunction
