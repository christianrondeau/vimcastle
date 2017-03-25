function! vimcastle#states#levelup#create() abort
	let instance = {}
	let instance.cansave = 1
	let instance.enter = function('s:enter')
	let instance.action_incr_con = function('s:action_incr_con')
	let instance.action_incr_str = function('s:action_incr_str')
	let instance.action_incr_spd = function('s:action_incr_spd')
	let instance.action_incr_dex = function('s:action_incr_dex')
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

function! s:action_incr_con(game) abort
	return s:increase(a:game, 'con', 1)
endfunction

function! s:action_incr_str(game) abort
	return s:increase(a:game, 'str', 1)
endfunction

function! s:action_incr_spd(game) abort
	return s:increase(a:game, 'spd', 1)
endfunction

function! s:action_incr_dex(game) abort
	return s:increase(a:game, 'dex', 1)
endfunction

function! s:increase(game, stat, by) abort
	let value = a:game.player.getstat(a:stat, 0)
	call a:game.player.setstat(a:stat, value + a:by)
	call s:continue(a:game)
endfunction

function! s:continue(game) abort
	let maxhealth = a:game.player.getmaxhealth()
	if(a:game.player.health < maxhealth)
		let a:game.player.health = maxhealth
	endif

	let a:game.player.level += 1

	let [expectedlevel, ignored] = vimcastle#levelling#forxp(a:game.player.xp)
	if(a:game.player.level < expectedlevel)
		return a:game.enter('levelup')
	else
		call a:game.event.enternext(a:game)
		return a:game.enter('explore')
	endif
endfunction
