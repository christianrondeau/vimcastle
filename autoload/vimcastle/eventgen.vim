let s:EventgenClass = {}

function! vimcastle#eventgen#create(name) abort
	let eventgen = copy(s:EventgenClass)
	let eventgen.name = a:name
	let eventgen.texts = []
	return eventgen
endfunction

function! s:EventgenClass.text(texts) dict abort
	call add(self.texts, type(a:texts) == 1 ? [a:texts] : a:texts)
	return self
endfunction

function! s:EventgenClass.explore(text) dict abort
	let self.action_explore_text = a:text
	return self
endfunction

function! s:EventgenClass.fight(text, monsters) dict abort
	let self.monsters = a:monsters
	let self.action_fight_text = a:text
	return self
endfunction

function! s:EventgenClass.finditem(items) dict abort
	let self.items = a:items
	return self
endfunction

function! s:EventgenClass.findequippable(equippables) dict abort
	let self.equippables = a:equippables
	return self
endfunction

function! s:EventgenClass.enterscene(text, scene) dict abort
	let self.nextscene = a:scene
	let self.action_enterscene_text = a:text
	return self
endfunction

function! s:EventgenClass.before(fn) dict abort
	let self.before_fn = a:fn
	return self
endfunction

function! s:EventgenClass.effect(name, value) dict abort
	let self.effect_name = a:name
	let self.effect_value = a:value
	return self
endfunction

function! s:EventgenClass.next(nextevent) dict abort
	let self.nextevent = a:nextevent
	return self
endfunction

function! s:EventgenClass.invoke(game) dict abort
	let a:game.stats.events += 1
	let event = vimcastle#event#create()

	if(exists('self.before_fn'))
		try
			call self.before_fn(a:game)
		catch
			throw 'There was an error in before fn of ' . a:game.scene.story . '/' . a:game.scene.name . '/' . self.name . ': ' . v:exception
		endtry
	endif

	if(exists('self.monsters'))
		let event.enemy = self.monsters.rnd().invoke()
	endif

	if(exists('self.items'))
		let event.item = self.items.rnd()
	endif

	if(exists('self.equippables'))
		let event.equippable = self.equippables.rnd().invoke()
	endif

	if(exists('self.nextevent'))
		let event.next = self.nextevent
	endif

	for lineoptions in self.texts
		let line = vimcastle#utils#oneof(lineoptions)
		call add(event.log, a:game.msgevent(line, event))
	endfor

	if(exists('event.equippable'))
		call s:showequippablediff(event.log, a:game, event)
	endif

	if(exists('self.effect_name'))
		let effect_value = exists('self.effect_value') ? self.effect_value : 0
		let effect_result = []
		execute 'let effect_result = vimcastle#effects#' . self.effect_name . '(a:game, effect_value)'
		call add(event.log, effect_result[1])
	endif

	let event.actions = self.createactions(event, a:game)

	return event
endfunction

function! s:EventgenClass.createactions(event, game) abort dict
	let actions = vimcastle#actions#create()

	if(exists('self.action_fight_text') && exists('a:event.enemy'))
	call actions.add('fight', 'f', self.action_fight_text . ' (level ' . a:event.enemy.level . ')')
	endif

	if(exists('self.action_enterscene_text'))
		let a:event.nextscene = self.nextscene
		let sceneinfo = {}
		execute 'let sceneinfo = vimcastle#stories#' . a:game.scene.story . '#' . a:event.nextscene . '#index#info()'
		call actions.add('enterscene', 'e', self.action_enterscene_text . ' (level ' . sceneinfo.level . ')')
	endif

	if(exists('a:event.item'))
		call actions.add('pickup', 'p', 'Pick up')
	endif

	if(exists('a:event.equippable'))
		call actions.add('equip', 'e', 'Equip')
	endif

	if(exists('self.action_explore_text'))
		call actions.add('explore', 'c', self.action_explore_text)
	endif

	if(!exists('self.action_fight_text'))
		call actions.add('inventory', 'i', 'Inventory')
		call actions.add('character', 's', 'Character Sheet')
	endif

	return actions
endfunction

function! s:showequippablediff(log, game, event) abort
	if(has_key(a:game.player.equipment, a:event.equippable.slot))
		let current = a:game.player.equipment[a:event.equippable.slot]
	else
		let current = vimcastle#equippablegen#create(a:event.equippable.slot, 0, 0)
	endif

	if(a:event.equippable.slot ==# 'weapon')
		call s:showequippabledmg(a:log, a:game, current, a:event.equippable)
	endif
	call s:showequippablestats(a:log, a:game, current, a:event.equippable)
endfunction

function! s:showequippabledmg(log, game, current, ground) abort
	let msg = '  * dmg: ' . s:getdiff(a:current['dmg'].min, a:ground['dmg'].min) . ' - ' . s:getdiff(a:current['dmg'].max, a:ground['dmg'].max)
	call add(a:log, msg)
endfunction

function! s:showequippablestats(log, game, current, ground) abort
	let allstats = copy(a:ground.stats)
	let curhasstats = exists('a:current.stats')
	if(curhasstats)
		for curkey in keys(a:current.stats)
			if(!has_key(allstats, curkey))
				let allstats[curkey] = a:current.stats[curkey]
			endif
		endfor
	endif
	for name in sort(keys(allstats))
		let currentval = curhasstats ? (has_key(a:current.stats, name) ? a:current.stats[name] : 0) : 0
		let groundval = has_key(a:ground.stats, name) ? a:ground.stats[name] : 0
		let msg = '  * ' . name . ': ' . s:getdiff(currentval, groundval)
	call add(a:log, msg)
	endfor
endfunction

function! s:getdiff(current, ground) abort
	if(a:ground > a:current)
		let diff = '+' . (a:ground - a:current)
	elseif(a:ground < a:current)
		let diff = '-' . (a:current - a:ground)
	else
		let diff = '='
	endif
	return a:ground . ' (' . diff . ')'
endfunction
