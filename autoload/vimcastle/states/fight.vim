function! vimcastle#states#fight#create() abort
	let instance = {}
	let instance.cansave = 1
	let instance.enter = function('s:enter')
	let instance.action_hit = function('s:action_hit')
	let instance.action_look = function('s:action_look')
	let instance.action_use = function('s:action_use')
	let instance.action_win = function('s:action_win')
	let instance.action_gameover = function('s:action_gameover')
	return instance
endfunction

function! s:enter(game) abort dict
	call s:setupactions(a:game)

	if(exists('a:game.enemy.fighting'))
		call s:hit_receive(a:game, self)
	else
		let a:game.enemy.fighting = 1
		if(a:game.player.getstat('spd', 1) >= a:game.enemy.getstat('spd', 1))
			call a:game.addlogrnd(['You attack first!', 'You have the opportunity!', 'You got the first strike!'])
		else
			call a:game.addlog('%<enemy.name> sees you first!')
			call s:hit_receive(a:game, self)
		endif
	endif
endfunction

function! s:setupactions(game) abort
	if(exists('a:game.player.equipment.weapon'))
		call a:game.actions.add('hit', 'a', 'Attack with <' . a:game.player.equipment.weapon.name.short . '>')
	endif
	call a:game.actions.add('look', 'l', 'Look at <' . a:game.enemy.name . '>')
	call a:game.actions.add('use', 'u', 'Use an item')
endfunction

function! s:action_hit(game) abort dict
	call s:setupactions(a:game)
	
	if(s:hit_send(a:game))
		return
	endif

	if(s:hit_receive(a:game, self))
		return
	endif
endfunction

function! s:action_look(game) abort dict
	call s:setupactions(a:game)
	
	call a:game.addlog('You look at %<enemy.name>')

	let text = []
	if(exists('a:game.enemy.description'))
		call add(text, '* ' . a:game.enemy.description)
	endif

	call add(text, '* Health: ' . a:game.enemy.health . '/' . a:game.enemy.getmaxhealth())

	let weapon = a:game.enemy.equipment.weapon
	call add(text, '* Weapon: %<enemy.weapon> (' . weapon.dmg.min . '-' . weapon.dmg.max . ' dmg)')

	call a:game.addlog(text)

	call s:hit_receive(a:game, self)
endfunction

function! s:hit_send(game) abort
	let dmg = vimcastle#resolver#hit(a:game.player, a:game.enemy)
	if(dmg > 0)
		call a:game.addlog('You hit %<enemy.name> with %<player.weapon> for <' . dmg . '> damage!')
	else
		call a:game.addlogrnd(['You miss!', 'You attack has no effect!'])
	endif

	if(a:game.enemy.health <= 0)
		call s:win(a:game)
		return 1
	endif
endfunction

function! s:hit_receive(game, self) abort
	let dmg = vimcastle#resolver#hit(a:game.enemy, a:game.player)

	if(dmg > 0)
		call a:game.addlog('%<enemy.name> hits you with %<enemy.weapon> for <' . dmg . '> damage!')
	else
		call a:game.addlogrnd(['%<enemy.name> misses you!', '%<enemy.name> attack has no effect!'])
	endif

	if(a:game.player.health <= 0)
		call s:dead(a:game, a:self)
		return 1
	endif
endfunction

function! s:win(game) abort
	call a:game.addlog('%<enemy.name> has been defeated!')
	call a:game.actions.clear()
	call a:game.actions.add('win', 'c', 'Continue')
endfunction

function! s:dead(game, self) abort
	let a:self.cansave = 0
	call vimcastle#io#clearsave()
	call add(a:game.log, 'You are dead.')
	call a:game.actions.clear()
	call a:game.actions.add('gameover', 'c', 'Continue')
endfunction

function! s:action_use(game) abort
	return a:game.enter('use')
endfunction

function! s:action_win(game) abort
	return a:game.enter('win')
endfunction

function! s:action_gameover(game) abort
	return a:game.enter('gameover')
endfunction
