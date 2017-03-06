function! vimcastle#state#fight#enter(state) abort
	call a:state.actions().clear()
	if(exists('a:state.player.equipment.weapon'))
		call a:state.actions().add('a', 'Attack with <' . a:state.player.equipment.weapon.name.short . '>', function('s:action_hit'))
	endif
	call a:state.actions().add('l', 'Look at <' . a:state.enemy.name.short . '>', function('s:action_look'))
	call a:state.actions().add('u', 'Use an item', function('s:action_use'))

	if(exists('a:state.enemy.fighting'))
		call s:hit_receive(a:state)
	else
		let a:state.enemy.fighting = 1
		let a:state.log = []
		if(a:state.player.getstat('spd', 1) >= a:state.enemy.getstat('spd', 1))
			call a:state.addlog(['You attack first!', 'You have the opportunity!', 'You got the first strike!'])
		else
			call a:state.addlog('%<enemy.name> sees you first!')
			call s:hit_receive(a:state)
		endif
	endif
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

	call a:state.addlog('* Health: ' . a:state.enemy.health . '/' . a:state.enemy.getmaxhealth())

	let weapon = a:state.enemy.equipment.weapon
	call a:state.addlog('* Weapon: %<enemy.weapon> (' . weapon.dmg.min . '-' . weapon.dmg.max . ' dmg)')

	if(s:hit_receive(a:state))
		return
	endif
endfunction

function! s:hit_send(state) abort
	let dmg = vimcastle#resolver#hit(a:state.player, a:state.enemy)
	if(dmg > 0)
		call a:state.addlog('You hit %<enemy.name> with %<player.weapon> for <' . dmg . '> damage!')
	else
		call a:state.addlog(['You miss!', 'You attack has no effect!'])
	endif

	if(a:state.enemy.health <= 0)
		call a:state.addlog('%<enemy.name> has been defeated!')
		call a:state.actions().clear()
		call a:state.actions().add('c', 'Continue', function('s:action_win'))
		return 1
	endif
endfunction

function! s:hit_receive(state) abort
	let dmg = vimcastle#resolver#hit(a:state.enemy, a:state.player)

	if(dmg > 0)
		call a:state.addlog('%<enemy.name> hits you with %<enemy.weapon> for <' . dmg . '> damage!')
	else
		call a:state.addlog(['%<enemy.name> misses you!', '%<enemy.name> attack has no effect!'])
	endif

	if(a:state.player.health <= 0)
		call add(a:state.log, 'You are dead.')
		call a:state.actions().clear()
		call a:state.actions().add('c', 'Continue', function('s:action_gameover'))
		return 1
	endif
endfunction

function! s:action_use(state) abort
	call a:state.clearlog()
	call a:state.enter('use')
endfunction

function! s:action_win(state) abort
		call a:state.enter('win')
endfunction

function! s:action_gameover(state) abort
		call a:state.enter('gameover')
endfunction
