function! vimcastle#state#fight#enter(state) abort
	let a:state.actions = [
		\{
		\  'name': 'Attack with <rust. short sword>',
		\  'fn': function('s:hit')
		\}
		\]
endfunction

function! vimcastle#state#fight#action(state, key) abort
	if(a:key > 0 && a:key <= len(a:state.actions))
		call a:state.actions[a:key-1].fn(a:state)
		return 1
	endif
endfunction

function! s:hit(state) abort
	let a:state.enemy.health.current -= 1
endfunction
