function! vimcastle#state#explore#enter(state) abort
	call s:event_nothing(a:state)
endfunction

function! s:action_continue(state)
	call s:events[vimcastle#utils#rnd(len(s:events))](a:state)
endfunction

function! s:action_fight(state)
	call a:state.enter('fight')
endfunction

function! s:event_nothing(state)
	let a:state.actions = {
		\'c': {
		\  'name': 'Continue',
		\  'fn': function('s:action_continue')
		\}
		\}
endfunction

function! s:event_fight(state)
	let a:state.enemy = vimcastle#character#random()
	let a:state.actions = {
		\'f': {
		\  'name': 'Fight!',
		\  'fn': function('s:action_fight')
		\}
		\}
endfunction

let s:events = [
	\  function('s:event_nothing'),
	\  function('s:event_fight')
	\]
