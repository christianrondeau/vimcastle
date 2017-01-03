function! vimcastle#state#fight#enter(state) abort
	let a:state.actions = [
		\{
		\  'name': 'Attack with <rust. short sword>',
		\  'fn': function('s:hit')
		\}
		\]
	let a:state.log = []
endfunction

function! vimcastle#state#fight#action(state, key) abort
	if(a:key > 0 && a:key <= len(a:state.actions))
		let a:state.log = []
		call a:state.actions[a:key-1].fn(a:state)
		return 1
	endif
endfunction

function! s:hit(state) abort
	let dmg = vimcastle#utils#rnd(3) + 1
	let a:state.enemy.health.current -= dmg
	call add(a:state.log, 'You hit ' . a:state.enemy.name.long . ' for ' . dmg . ' damage!')
	if(a:state.enemy.health.current <= 0)
		call a:state.enter('win')
	endif

	let dmg = vimcastle#utils#rnd(3) + 1
	let a:state.player.health.current -= dmg
	call add(a:state.log, a:state.enemy.name.long . ' hits you for ' . dmg . ' damage!')
	if(a:state.player.health.current <= 0)
		call a:state.enter('lose')
	endif
endfunction
