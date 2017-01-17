function! vimcastle#state#fight#enter(state) abort
	let a:state.actions.enabled = 1
	call a:state.actions.clear()
	call a:state.actions.add('a', 'Attack with <' . a:state.player.weapon.name.short . '>', function('s:action_hit'))
	call a:state.actions.add('l', 'Look at <' . a:state.enemy.name.long . '>', function('s:action_look'))
endfunction

function! s:action_hit(state) abort
	let a:state.log = []

	if(s:hit_send(a:state))
		return
	endif

	if(s:hit_receive(a:state))
		return
	endif
endfunction

function! s:action_look(state) abort
	let a:state.log = []

	call add(a:state.log, 'You look at <' . a:state.enemy.name.long . '>')
	call add(a:state.log, '* Health: ' . a:state.enemy.health.current . '/' . a:state.enemy.health.max)
	call add(a:state.log, '* Weapon: <' . a:state.enemy.weapon.name.long . '> (' . a:state.enemy.weapon.dmg.min . '-' . a:state.enemy.weapon.dmg.max . ' dmg)')

	if(s:hit_receive(a:state))
		return
	endif
endfunction

function! s:hit_send(state) abort
	let dmg = s:compute_hit(a:state.player, a:state.enemy)
	call add(a:state.log, 'You hit <' . a:state.enemy.name.long . '> with <' . a:state.player.weapon.name.long . '> for ' . dmg . ' damage!')

	if(a:state.enemy.health.current <= 0)
		call add(a:state.log, '<' . a:state.enemy.name.long . '> has been defeated!')
		call a:state.actions.clear()
		call a:state.actions.add('c', 'Continue', function('s:action_win'))
		return 1
	endif
endfunction

function! s:hit_receive(state) abort
	let dmg = s:compute_hit(a:state.enemy, a:state.player)
	call add(a:state.log, '<' . a:state.enemy.name.long . '> hits you with <' . a:state.enemy.weapon.name.long . '> for ' . dmg . ' damage!')
	if(a:state.player.health.current <= 0)
		call add(a:state.log, 'You are dead.')
		call a:state.actions.clear()
		call a:state.actions.add('c', 'Continue', function('s:action_gameover'))
		return 1
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
