function! vimcastle#state#fight#enter(state) abort
	let a:state.actions.enabled = 1
	call a:state.actions.clear()
	call a:state.actions.add('a', 'Attack with <' . a:state.player.equipment.weapon.name.short . '>', function('s:action_hit'))
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

	call a:state.addlog('You look at %<enemy.name>')

	let health = a:state.enemy.health
	call a:state.addlog('* Health: ' . health.current . '/' . health.max)

	let weapon = a:state.enemy.equipment.weapon
	call a:state.addlog('* Weapon: %<enemy.weapon> (' . weapon.dmg.min . '-' . weapon.dmg.max . ' dmg)')

	if(s:hit_receive(a:state))
		return
	endif
endfunction

function! s:hit_send(state) abort
	let dmg = s:compute_hit(a:state.player, a:state.enemy)
	call a:state.addlog('You hit %<enemy.name> with %<player.weapon> for ' . dmg . ' damage!')

	if(a:state.enemy.health.current <= 0)
		call a:state.addlog('%<enemy.name> has been defeated!')
		call a:state.actions.clear()
		call a:state.actions.add('c', 'Continue', function('s:action_win'))
		return 1
	endif
endfunction

function! s:hit_receive(state) abort
	let dmg = s:compute_hit(a:state.enemy, a:state.player)
	call a:state.addlog('%<enemy.name> hits you with %<enemy.weapon> for ' . dmg . ' damage!')
	if(a:state.player.health.current <= 0)
		call add(a:state.log, 'You are dead.')
		call a:state.actions.clear()
		call a:state.actions.add('c', 'Continue', function('s:action_gameover'))
		return 1
	endif
endfunction

function! s:compute_hit(attacker, defender) abort
	let weapon = a:attacker.equipment.weapon
	let dmgmin = weapon.dmg.min
	let dmgmax = weapon.dmg.max
	let dmg = vimcastle#utils#rnd(dmgmax - dmgmin + 1) + dmgmin
	if(exists('a:defender.equipment.armor'))
		let dmg -= a:defender.equipment.armor.stats.def
	endif
	if(dmg < 0)
		let dmg = 0
	endif
	let a:defender.health.current -= dmg
	if(a:defender.health.current < 0)
		let a:defender.health.current = 0
	endif
	return dmg
endfunction

function! s:action_win(state)
		call a:state.enter('win')
endfunction

function! s:action_gameover(state)
		call a:state.enter('gameover')
endfunction
