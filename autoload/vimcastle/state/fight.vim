function! vimcastle#state#fight#enter(state) abort
	let a:state.actions = {
		\'a': {
		\  'name': 'Attack with <rust. short sword>',
		\  'fn': function('s:action_hit')
		\}
		\}
endfunction

function! s:action_hit(state) abort
	let a:state.log = []

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
