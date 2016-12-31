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
	let dmg = s:random(3) + 1
	let a:state.enemy.health.current -= dmg
	call add(a:state.log, 'You hit ' . a:state.enemy.name.long . ' for ' . dmg . ' damage!')

	let dmg = s:random(3) + 1
	let a:state.player.health.current -= dmg
	call add(a:state.log, a:state.enemy.name.long . ' hits you for ' . dmg . ' damage!')
endfunction

function! s:hitone(state, character) abort
	let dmg = s:random(3) + 1
	let a:state.enemy.health.current -= dmg
	call add(a:state.log, 'You hit ' . a:state.enemy.name.long . ' for ' . dmg . ' damage!')
endfunction

let s:rndseed = localtime() % 0x10000
function! s:random(n) abort
	let s:rndseed = (s:rndseed * 31421 + 6927) % 0x10000
	return s:rndseed * a:n / 0x10000
endfunction
