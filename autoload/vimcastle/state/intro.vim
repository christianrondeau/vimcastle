function! vimcastle#state#intro#enter(state) abort
	let a:state.actions = {
		\'any': {
		\  'name': 'Start',
		\  'fn': function('s:action_start')
		\}
		\}
endfunction

function! s:action_start(state) abort
	call a:state.enter('menu')
	return 1
endfunction
