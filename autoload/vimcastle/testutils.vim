let s:VimcastleTestutilsClass = {}

function! vimcastle#testutils#create() abort
	let utils = copy(s:VimcastleTestutilsClass)
	let utils.totalturns = 0
	let utils.playthroughsturns = []
	return utils
endfunction

function! vimcastle#testutils#noop(...) abort
endfunction

function! s:VimcastleTestutilsClass.givengame(story, level) dict abort
	let game = vimcastle#game#create()
  let game.scene = vimcastle#scene#loadintro(a:story)
	let game.event = game.scene.enter.invoke(game)
  let game.scene.events = vimcastle#repository#create().add(1, vimcastle#eventgen#create('empty'))
	call game.enter('explore')
	if(a:level > 1)
		call game.player.equip(vimcastle#equippablegen#weapon('T. Weap.', 'Test Weapon', a:level * 5 / 3, a:level * 5 / 3).invoke())
		call game.player.equip(vimcastle#equippablegen#armor('T. Arm.', 'Test Armor', a:level * 3 / 2).invoke())
		while(game.player.level < a:level)
			let next = vimcastle#levelling#forxp(game.player.xp)
			let game.player.xp = next[1]
			call game.enter('levelup')
			call self.playlevelup({'log': []}, game)
		endwhile
	endif
	return game
endfunction

function! s:VimcastleTestutilsClass.autofight(game, monster) dict abort
	let a:game.enemy = a:monster
	call a:game.enter('fight')
	let stats = {'log': []}
	let turns = 0
	while(a:game.player.health > 0 && a:game.enemy.health > 0)
		let turns += 1
		call self.playfight(stats, a:game)
		if(turns > 100)
			throw 'Infinite loop: ' . string(stats.log)
		endif
	endwhile
	return stats
endfunction

function! s:VimcastleTestutilsClass.playgames(maxplaythroughs, maxturns) dict abort
	let totalstats = {}
	let totalstats.playthroughs = 0
	let totalstats.turns = 0
	let totalstats.levels = 0
	let totalstats.playthroughsturns = []

	while(totalstats.playthroughs < a:maxplaythroughs)
		let totalstats.playthroughs += 1
		let gamestats = self.playgame(a:maxturns)
		let totalstats.turns += gamestats.turns
		let totalstats.levels += gamestats.level
		call add(totalstats.playthroughsturns, gamestats.turns)
	endwhile

	let totalstats.avgturns = totalstats.turns / a:maxplaythroughs
	let totalstats.avglevels = totalstats.levels / a:maxplaythroughs
	return totalstats
endfunction

function! s:VimcastleTestutilsClass.playgame(maxturns) dict abort
	let stats = {}
	let stats.turns = 0
	let stats.log = []

	let game = vimcastle#game#create()
	let game.scene = vimcastle#scene#loadintro('main')
	let game.event = game.scene.enter.invoke(game)
	call game.enter('explore')
	let stats.log += game.log

	while stats.turns < a:maxturns && game.screen !=# 'gameover'
		let stats.turns += 1
		call add(stats.log, '---- TURN ' . stats.turns)
		let health = game.player.health

		call self.playauto(stats, game)

		let stats.log += game.log
		if(health != game.player.health)
			call add(stats.log, 'HEALTH: ' . game.player.health)
		endif
		call add(stats.log, 'ACTIONS: ' . join(game.actions.names(), ', '))
	endwhile

	let stats.level = game.player.level

	return stats
endfunction

function! s:VimcastleTestutilsClass.playauto(stats, game) dict abort
		if(exists('a:game.event.equippable'))
			call self.playfindequippable(a:stats, a:game)
		elseif(a:game.screen ==# 'fight')
			call self.playfight(a:stats, a:game)
		elseif(a:game.screen ==# 'levelup')
			call self.playlevelup(a:stats, a:game)
		else
			call self.playdefault(a:stats, a:game)
		endif
endfunction

function! s:VimcastleTestutilsClass.playdefault(stats, game) dict abort
		let action = a:game.actions.keys()[0]
		call add(a:stats.log, 'PLAY: ' . action . ' (default)')
		call a:game.action(action)
endfunction

function! s:VimcastleTestutilsClass.playfight(stats, game) dict abort
	let itemidx = s:indexofitemwitheffect(a:game.player.items, 'heal')
	let actions = a:game.actions.keys()
	if(actions[0] ==# 'c')
		call add(a:stats.log, 'PLAY: c (fight complete)')
		call a:game.action('c')
	elseif(itemidx > -1 && a:game.player.health < (a:game.player.getmaxhealth() / 3))
		let itemn = itemidx + 1
		call add(a:stats.log, 'PLAY: u, ' . itemn . ', b (heal with item)')
		call a:game.action('u')
		call a:game.action('' . itemn)
		call a:game.action('b')
	else
		call add(a:stats.log, 'PLAY: a (can attack)')
		call a:game.action('a')
		call add(a:stats.log, 'RESULT: player: ' . a:game.player.health . ', enemy: ' . a:game.enemy.health)
	endif
endfunction

function! s:VimcastleTestutilsClass.playlevelup(stats, game) dict abort
	let minvalue = 999999
	let minaction = {}
	for action in a:game.actions.bindings
		let value = matchstr(action.label, '\v[0-9]+') + 0
		if(value < minvalue)
			let minvalue = value
			let minaction = action
		endif
	endfor
	if(exists('minaction.key'))
		call add(a:stats.log, 'PLAY: ' . minaction.key . ' (lowest stat)')
		call a:game.action(minaction.key)
	else
		call self.playdefault(a:stats, a:game)
	endif
endfunction

function! s:VimcastleTestutilsClass.playfindequippable(stats, game) dict abort
	if(a:game.event.equippable.score > a:game.player.equipment.weapon.score)
		call add(a:stats.log, 'PLAY: e (better equipment)')
		call a:game.action('e')
	else
		call add(a:stats.log, 'PLAY: c (worse equipment)')
		call a:game.action('c')
	endif
endfunction

function! s:indexofitemwitheffect(items, effect) abort
	let i = 0
	while i < 9 && i < len(a:items)
		let item = a:items[i]
		if(item.effect ==# a:effect)
			return i
		endif
		let i += 1
	endwhile
	return -1
endfunction
