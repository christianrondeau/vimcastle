function! vimcastle#state#fight#enter(state) abort
	call a:state.actions.add('a', 'Attack with <' . a:state.player.weapon.name.short . '>', function('s:action_hit'))
endfunction

function! s:action_hit(state) abort
	let a:state.log = []

	let dmg = s:compute_hit(a:state.player, a:state.enemy)
	call add(a:state.log, 'You hit <' . a:state.enemy.name.long . '> for ' . dmg . ' damage!')
	if(a:state.enemy.health.current <= 0)
		call add(a:state.log, '<' . a:state.enemy.name.long . '> has been defeated!')
		call a:state.actions.clear()
		call a:state.actions.add('c', 'Continue', function('s:action_win'))
		return
	endif

	let dmg = s:compute_hit(a:state.enemy, a:state.player)
	call add(a:state.log, '<' . a:state.enemy.name.long . '> hits you for ' . dmg . ' damage!')
	if(a:state.player.health.current <= 0)
		call add(a:state.log, 'You are dead.')
		call a:state.actions.clear()
		call a:state.actions.add('c', 'Continue', function('s:action_gameover'))
		return
	endif
endfunction

function! s:compute_hit(attacker, victim) abort
	let weapon = a:attacker.weapon
	let dmgmin = weapon.dmg.min
	let dmgmax = weapon.dmg.max
	let dmg = vimcastle#utils#rnd(dmgmax - dmgmin + 1) + dmgmin
	let a:victim.health.current -= dmg
	if(a:victim.health.current < 0)
		let a:victim.health.current = 0
	endif
	return dmg
endfunction

function! s:action_win(state)
		call a:state.enter('win')
endfunction

function! s:action_gameover(state)
		call a:state.enter('gameover')
endfunction
