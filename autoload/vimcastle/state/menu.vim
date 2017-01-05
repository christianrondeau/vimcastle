function! vimcastle#state#menu#enter(state) abort
	let a:state.actions = {
		\'n': {
		\  'name': 'New Game',
		\  'fn': function('s:action_newgame')
		\},
		\'h': {
		\  'name': 'Help',
		\  'fn': function('s:action_help')
		\},
		\'q': {
		\  'name': 'Quit'
		\}
		\}
endfunction

function! s:action_newgame(state) abort
	call a:state.newgame()
	return 1
endfunction

function! s:action_help(state) abort
	help Vimcastle
endfunction
