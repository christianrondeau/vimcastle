let s:VimcastleTestutilsClass = {}

function! vimcastle#testutils#create() abort
	let utils = copy(s:VimcastleTestutilsClass)
	let utils.totalturns = 0
	let utils.playthroughsturns = []
	return utils
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

	let state = vimcastle#state#create()
	let state.scene = vimcastle#scene#load('main', 'index')
	call state.enter('explore')
	call state.scene.enter.invoke(state)
	let stats.log += state.log

	while stats.turns < a:maxturns && state.screen != 'gameover'
		let stats.turns += 1
		call add(stats.log, '---- TURN ' . stats.turns)
		let health = state.player.health

		if(exists('state.ground_equippable'))
			call self.playfindequippable(stats, state)
		elseif(state.screen == 'fight')
			call self.playfight(stats, state)
		else
			call self.playdefault(stats, state)
		endif

		let stats.log += state.log
		if(health != state.player.health)
			call add(stats.log, 'HEALTH: ' . state.player.health)
		endif
		let actionsshort = ''
		for a in state.actions().display
			let actionsshort .= a.key
		endfor
		call add(stats.log, 'ACTIONS: ' . actionsshort)
	endwhile

	let stats.level = state.player.level

	return stats
endfunction

function! s:VimcastleTestutilsClass.playdefault(stats, state) dict abort
		let actions = a:state.actions()
		let key = actions.display[0].key
		call add(a:stats.log, 'PLAY: ' . key . ' (default)')
		call actions.invokeByKey(key, a:state)
endfunction

function! s:VimcastleTestutilsClass.playfight(stats, state) dict abort
	let itemidx = s:indexofitemwitheffect(a:state.player.items, 'heal')
	if(a:state.actions().display[0].key == 'c')
		call add(a:stats.log, 'PLAY: c (fight complete)')
		call a:state.actions().invokeByKey('c', a:state)
	elseif(itemidx > -1 && a:state.player.health < (a:state.player.getstat('health', 1) / 3))
		call add(a:stats.log, 'PLAY: u' . itemidx . 'heal')
		call a:state.actions().invokeByKey('u', a:state)
		call a:state.actions().invokeByKey(string(itemidx + 1), a:state)
	else
		call add(a:stats.log, 'PLAY: a (can attack)')
		call a:state.actions().invokeByKey('a', a:state)
	endif
endfunction

function! s:VimcastleTestutilsClass.playfindequippable(stats, state) dict abort
	if(a:state.ground_equippable.score > a:state.player.equipment.weapon.score)
		call add(a:stats.log, 'PLAY: e (better equipment)')
		call a:state.actions().invokeByKey('e', a:state)
	else
		call add(a:stats.log, 'PLAY: c (worse equipment)')
		call a:state.actions().invokeByKey('c', a:state)
	endif
endfunction

function! s:indexofitemwitheffect(items, effect) abort
	let i = 0
	while i < 9 && i < len(a:items)
		let item = a:items[i]
		if(item.effect == a:effect)
			return i
		endif
		let i += 1
	endwhile
	return -1
endfunction
