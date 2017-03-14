function! vimcastle#states#levelup#create() abort
	let instance = {}
	let instance.enter = function('s:enter')
	let instance.action = function('s:action')
	return instance
endfunction

function! s:enter(game) abort
	let a:game.log = ['Your health was replenished! Select a skill to increase.']

	call a:game.actions.clear()

	call s:addincreaseaction('1', a:game, 'con', 1)
	call s:addincreaseaction('2', a:game, 'str', 1)
	call s:addincreaseaction('3', a:game, 'spd', 1)
	call s:addincreaseaction('4', a:game, 'dex', 1)
endfunction

function! s:action(name, game) abort
	execute 'call s:action_' . a:name . '(a:game)'
endfunction

function! s:addincreaseaction(index, game, stat, by) abort
	let value = a:game.player.getstat(a:stat, 0)
	let msg = 'Increase ' . a:stat . ' ' . value . ' -> ' . (value + a:by)
	call a:game.actions.add('incr_' . a:stat, a:index, msg)
endfunction

function! s:action_incr_str(game) abort
	return s:action_incr(a:game, 'str', 1)
endfunction

function! s:action_incr_spd(game) abort
	return s:action_incr(a:game, 'spd', 1)
endfunction

function! s:action_incr_dex(game) abort
	return s:action_incr(a:game, 'dex', 1)
endfunction

function! s:action_incr_con(game) abort
	return s:action_incr(a:game, 'con', 1)
endfunction

function! s:action_incr(game, stat, by) abort
	let value = a:game.player.getstat(a:stat, 0)
	call a:game.player.setstat(a:stat, value + a:by)
	call s:action_continue(a:game)
endfunction

function! s:action_continue(game) abort
	let maxhealth = a:game.player.getmaxhealth()
	if(a:game.player.health < maxhealth)
		let a:game.player.health = maxhealth
	endif

	let a:game.player.level += 1

	let [expectedlevel, ignored] = vimcastle#levelling#forxp(a:game.player.xp)
	if(a:game.player.level < expectedlevel)
		return a:game.enter('levelup')
	else
		let a:game.event = a:game.scene.events.rnd().invoke(a:game)
		call a:game.event.enter(a:game)
		return a:game.enter('explore')
	endif
endfunction
