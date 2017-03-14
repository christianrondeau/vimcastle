function! vimcastle#states#fight#create() abort
	let instance = {}
	let instance.enter = function('s:enter')
	let instance.action = function('s:action')
	return instance
endfunction

function! s:enter(game) abort dict
	call s:setupactions(a:game)

	if(exists('a:game.enemy.fighting'))
		call s:hit_receive(a:game)
	else
		let a:game.enemy.fighting = 1
		if(a:game.player.getstat('spd', 1) >= a:game.enemy.getstat('spd', 1))
			call a:game.addlogrnd(['You attack first!', 'You have the opportunity!', 'You got the first strike!'])
		else
			call a:game.addlog('%<enemy.name> sees you first!')
			call s:hit_receive(a:game)
		endif
	endif
endfunction

function! s:action(name, game) abort dict
	call s:setupactions(a:game)
	execute 'return s:action_' . a:name . '(a:game)'
endfunction

function! s:setupactions(game) abort
	if(exists('a:game.player.equipment.weapon'))
		call a:game.actions.add('hit', 'a', 'Attack with <' . a:game.player.equipment.weapon.name.short . '>')
	endif
	call a:game.actions.add('look', 'l', 'Look at <' . a:game.enemy.name.short . '>')
	call a:game.actions.add('use', 'u', 'Use an item')
endfunction

function! s:action_hit(game) abort
	if(s:hit_send(a:game))
		return
	endif

	if(s:hit_receive(a:game))
		return
	endif
endfunction

function! s:action_look(game) abort
	call a:game.addlog('You look at %<enemy.name>')

	let text = []
	if(exists('a:game.enemy.description'))
		call add(text, '* ' . a:game.enemy.description)
	endif

	call add(text, '* Health: ' . a:game.enemy.health . '/' . a:game.enemy.getmaxhealth())

	let weapon = a:game.enemy.equipment.weapon
	call add(text, '* Weapon: %<enemy.weapon> (' . weapon.dmg.min . '-' . weapon.dmg.max . ' dmg)')

	call a:game.addlog(text)

	call s:hit_receive(a:game)
endfunction

function! s:hit_send(game) abort
	let dmg = vimcastle#resolver#hit(a:game.player, a:game.enemy)
	if(dmg > 0)
		call a:game.addlog('You hit %<enemy.name> with %<player.weapon> for <' . dmg . '> damage!')
	else
		call a:game.addlogrnd(['You miss!', 'You attack has no effect!'])
	endif

	if(a:game.enemy.health <= 0)
		call a:game.addlog('%<enemy.name> has been defeated!')
		call a:game.actions.clear()
		call a:game.actions.add('win', 'c', 'Continue')
		return 1
	endif
endfunction

function! s:hit_receive(game) abort
	let dmg = vimcastle#resolver#hit(a:game.enemy, a:game.player)

	if(dmg > 0)
		call a:game.addlog('%<enemy.name> hits you with %<enemy.weapon> for <' . dmg . '> damage!')
	else
		call a:game.addlogrnd(['%<enemy.name> misses you!', '%<enemy.name> attack has no effect!'])
	endif

	if(a:game.player.health <= 0)
		call add(a:game.log, 'You are dead.')
		call a:game.actions.clear()
		call a:game.actions.add('gameover', 'c', 'Continue')
		return 1
	endif
endfunction

function! s:action_use(game) abort
	call a:game.clearlog()
	return a:game.enter('use')
endfunction

function! s:action_win(game) abort
		return a:game.enter('win')
endfunction

function! s:action_gameover(game) abort
		return a:game.enter('gameover')
endfunction
