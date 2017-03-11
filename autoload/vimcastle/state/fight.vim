function! vimcastle#state#fight#enter(state) abort
	call a:state.actions().clear()
	if(exists('a:state.player.equipment.weapon'))
		call a:state.actions().add('hit', 'a', 'Attack with <' . a:state.player.equipment.weapon.name.short . '>')
	endif
	call a:state.actions().add('look', 'l', 'Look at <' . a:state.enemy.name.short . '>')
	call a:state.actions().add('use', 'u', 'Use an item')

	if(exists('a:state.enemy.fighting'))
		call s:hit_receive(a:state)
	else
		let a:state.enemy.fighting = 1
		call a:state.clearlog()
		if(a:state.player.getstat('spd', 1) >= a:state.enemy.getstat('spd', 1))
			call a:state.addlogrnd(['You attack first!', 'You have the opportunity!', 'You got the first strike!'])
		else
			call a:state.addlog('%<enemy.name> sees you first!')
			call s:hit_receive(a:state)
		endif
	endif
endfunction

function! vimcastle#state#fight#action(name, state) abort
	execute 'call s:action_' . a:name . '(a:state)'
endfunction

function! s:action_hit(state) abort
	call a:state.clearlog()

	if(s:hit_send(a:state))
		return
	endif

	if(s:hit_receive(a:state))
		return
	endif
endfunction

function! s:action_look(state) abort
	call a:state.clearlog()

	call a:state.addlog('You look at %<enemy.name>')

	let text = []
	if(exists('a:state.enemy.description'))
		call add(text, '* ' . a:state.enemy.description)
	endif

	call add(text, '* Health: ' . a:state.enemy.health . '/' . a:state.enemy.getmaxhealth())

	let weapon = a:state.enemy.equipment.weapon
	call add(text, '* Weapon: %<enemy.weapon> (' . weapon.dmg.min . '-' . weapon.dmg.max . ' dmg)')

	call a:state.addlog(text)

	call s:hit_receive(a:state)
endfunction

function! s:hit_send(state) abort
	let dmg = vimcastle#resolver#hit(a:state.player, a:state.enemy)
	if(dmg > 0)
		call a:state.addlog('You hit %<enemy.name> with %<player.weapon> for <' . dmg . '> damage!')
	else
		call a:state.addlogrnd(['You miss!', 'You attack has no effect!'])
	endif

	if(a:state.enemy.health <= 0)
		call a:state.addlog('%<enemy.name> has been defeated!')
		call a:state.actions().clear()
		call a:state.actions().add('win', 'c', 'Continue')
		return 1
	endif
endfunction

function! s:hit_receive(state) abort
	let dmg = vimcastle#resolver#hit(a:state.enemy, a:state.player)

	if(dmg > 0)
		call a:state.addlog('%<enemy.name> hits you with %<enemy.weapon> for <' . dmg . '> damage!')
	else
		call a:state.addlogrnd(['%<enemy.name> misses you!', '%<enemy.name> attack has no effect!'])
	endif

	if(a:state.player.health <= 0)
		call add(a:state.log, 'You are dead.')
		call a:state.actions().clear()
		call a:state.actions().add('gameover', 'c', 'Continue')
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
