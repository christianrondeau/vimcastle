function! vimcastle#effects#none(game, value) abort
	return [1, 'This has no effect']
endfunction

function! vimcastle#effects#heal(game, value) abort
	let maxhealth = a:game.player.getmaxhealth()

	if(a:game.player.health >= maxhealth)
		return [0, 'Your health is already full!']
	endif

	let a:game.player.health += a:value

	if(a:game.player.health >= maxhealth)
		let a:game.player.health = maxhealth
		return [1, 'Your health is fully replenished!']
	else
		return [1, 'You gain <+' . a:value . '> health.']
	endif
endfunction

function! vimcastle#effects#gainhealth(game, value) abort
	let a:game.player.basehealth += a:value
	let a:game.player.health  += a:value
	return [1, 'You gain <+' . a:value . '> to your maximum health permanently.']
endfunction

function! vimcastle#effects#gainstr(game, value) abort
	call s:incrstat(a:game, 'str', a:value)
	return [1, 'You feel stronger! gain <+' . a:value . '> to your strength permanently.']
endfunction

function! s:incrstat(game, stat, value) abort
	call a:game.player.setstat(a:stat, a:game.player.getstat(a:stat, 0) + a:value)
endfunction

function! vimcastle#effects#damage(game, value) abort
	if(!exists('a:game.enemy'))
		return [0, 'No enemy to target!']
	endif

	if(a:game.enemy.health <= 0)
		return [0, 'Enemy already dead']
	endif

	let a:game.enemy.health -= a:value
	if(a:game.enemy.health < 0)
		let a:game.enemy.health = 0
	endif

	return [1, 'You hurt <' . a:game.enemy.name . '> for <' . a:value . '> damage.']
endfunction
